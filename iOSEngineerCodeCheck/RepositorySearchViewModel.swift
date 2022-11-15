import Foundation
import RxSwift
import RxCocoa

final class RepositorySearchViewModel {
    private let disposeBag = DisposeBag()
    private let githubAPI: GitHubAPIProtocol
    
    init(githubAPI: GitHubAPIProtocol = GitHubAPI()) {
        self.githubAPI = githubAPI
    }
}

extension RepositorySearchViewModel: ViewModelType {
    struct Input {
        let searchText:         Observable<String>
        let searchButtonTapped: Observable<Void>
        let selectedRepository: Observable<IndexPath>
    }
    
    struct Output {
        let repositories:       Driver<[GitHubRepository]>
        let selectedRepository: Driver<GitHubRepository>
        let searchDescription:  Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let repositories       = BehaviorRelay<[GitHubRepository]>(value: [])
        let selectedRepository = PublishRelay<GitHubRepository>()
        let searchDescription  = PublishRelay<String>()
        
        input.searchButtonTapped
            .withLatestFrom(input.searchText)
            .flatMapLatest { [unowned self] searchText -> Observable<Event<[GitHubRepository]>> in
                
                var repositories: [GitHubRepository] = []
                
                self.githubAPI.searchRepositories(keyword: searchText) { result in
                    
                    switch result {
                    case .success(let response):
                        repositories = response
                    case .failure(let error):
                        print(error)
                    }
                }
                
                return Observable.just(repositories)
                    .materialize()
            }
            .subscribe(onNext: { result in
                switch result {
                case .next(let response):
                    repositories.accept(response)
                    
                default:
                    break
                }
                
            })
            .disposed(by: disposeBag)
        
        input.searchButtonTapped
            .withLatestFrom(input.searchText) { _, searchText -> String in
                // 前後の余計な空白を削除する
                let descriptionWord = searchText.trimmingCharacters(in: .whitespaces)
                
                // 検索ワードが25文字以上なら省略する
                if descriptionWord.count >= 25 {
                    return "\(descriptionWord.prefix(25).description)...の検索結果"
                }
                
                return "\(descriptionWord)の検索結果"
            }
            .bind(to: searchDescription)
            .disposed(by: disposeBag)
        
        input.selectedRepository
            .withLatestFrom(repositories) { indexPath, repositories in
                return repositories[indexPath.row]
            }
            .bind(to: selectedRepository)
            .disposed(by: disposeBag)
        
        return Output(
            repositories: repositories.asDriver(),
            selectedRepository: selectedRepository.asDriver(onErrorDriveWith: .empty()),
            searchDescription: searchDescription.asDriver(onErrorDriveWith: .empty())
        )
    }
}
