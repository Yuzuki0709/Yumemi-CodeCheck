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
        let error:              Driver<Error>
        let isLoading:          Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let selectedRepository = PublishRelay<GitHubRepository>()
        let searchDescription  = PublishRelay<String>()
        let isLoading          = BehaviorRelay<Bool>(value: false)
        
        let response = input.searchButtonTapped
            .withLatestFrom(input.searchText)
            .flatMapLatest { [unowned self] searchText -> Observable<Event<[GitHubRepository]>> in
                isLoading.accept(true)
                
                return self.githubAPI
                    .searchRepositories(keyword: searchText)
                    .materialize()
            }
            .share()
        
        response
            .subscribe(onNext: { _ in
                isLoading.accept(false)
            })
            .disposed(by: disposeBag)
        
        let repositories = response.elements()
        let error        = response.errors()
        
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
            repositories: repositories.asDriver(onErrorDriveWith: .empty()),
            selectedRepository: selectedRepository.asDriver(onErrorDriveWith: .empty()),
            searchDescription: searchDescription.asDriver(onErrorDriveWith: .empty()),
            error: error.asDriver(onErrorDriveWith: .empty()),
            isLoading: isLoading.asDriver()
        )
    }
}
