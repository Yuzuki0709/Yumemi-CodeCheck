import Foundation
import RxSwift
import RxCocoa

final class RepositoryDetailViewModel {
    private let disposeBag = DisposeBag()
    
    private let repository: GitHubRepository
    private let githubAPI:  GitHubAPIProtocol
    
    init(repository: GitHubRepository, githubAPI: GitHubAPIProtocol = GitHubAPI()) {
        self.repository = repository
        self.githubAPI  = githubAPI
    }
}

extension RepositoryDetailViewModel: ViewModelType {
    struct Input {
        let viewWillAppear:  Observable<Void>
        let tableCellTapped: Observable<IndexPath>
    }
    
    struct Output {
        let isExistHomepage: Driver<Bool>
        let isExistReadme:   Driver<Bool>
        let goHomepageView:  Driver<URL>
        let goReadmeView:    Driver<URL>
    }
    
    func transform(input: Input) -> Output {
        
        var homepageURL: URL? = nil
        var readmeURL:   URL? = nil
        
        let isExistHomepage = BehaviorRelay<Bool>(value: false)
        let isExistReadme   = BehaviorRelay<Bool>(value: false)
        let goHomepageView  = PublishRelay<URL>()
        let goReadmeView    = PublishRelay<URL>()
        
        input.viewWillAppear
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                // ホームページが存在するかどうかを判別
                if let homepageURLString = self.repository.homepage,
                   !homepageURLString.isEmpty {
                    homepageURL = URL(string: homepageURLString)
                    isExistHomepage.accept(true)
                }
            })
            .disposed(by: disposeBag)
        
        // READMEがあるかどうかを判定
        input.viewWillAppear
            .flatMap { [unowned self] _ -> Observable<Event<GitHubReadme>> in
                return self.githubAPI
                    .searchReadme(ownerName: self.repository.owner.login,
                                  repositoryName: self.repository.name)
                    .materialize()
            }
            .subscribe(onNext: { event in
                switch event {
                case .next(let response):
                    readmeURL = URL(string: response.htmlURL)
                    isExistReadme.accept(true)
                    
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        // indexPahtを使用して、タップされたセルを特定している
        // もっといい方法がありそう
        input.tableCellTapped
            .subscribe(onNext: { indexPath in
                if indexPath.row == 0 {
                    // ホームページセルはホームページのURLが有効な場合のみ表示されるので、
                    // 強制アンラップにしている
                    goHomepageView.accept(homepageURL!)
                } else if indexPath.row == 1 {
                    // 上と同じ理由で強制アンラップしている
                    goReadmeView.accept(readmeURL!)
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            isExistHomepage: isExistHomepage.asDriver(),
            isExistReadme: isExistReadme.asDriver(),
            goHomepageView: goHomepageView.asDriver(onErrorDriveWith: .empty()),
            goReadmeView: goReadmeView.asDriver(onErrorDriveWith: .empty())
        )
    }
}
