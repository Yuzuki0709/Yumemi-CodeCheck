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
        let goHomepageView:  Driver<URL>
    }
    
    func transform(input: Input) -> Output {
        
        var homepageURL: URL? = nil
        
        let isExistHomepage = BehaviorRelay<Bool>(value: false)
        let goHomepageView  = PublishRelay<URL>()
        
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
        
        input.tableCellTapped
            .subscribe(onNext: { indexPath in
                if indexPath.row == 0 {
                    // ホームページセルはホームページのURLが有効な場合のみ表示されるので、
                    // 強制アンラップにしている
                    goHomepageView.accept(homepageURL!)
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            isExistHomepage: isExistHomepage.asDriver(),
            goHomepageView: goHomepageView.asDriver(onErrorDriveWith: .empty())
        )
    }
}
