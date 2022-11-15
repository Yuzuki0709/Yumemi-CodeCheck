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
        
        return Output(
            repositories: repositories.asDriver(),
            selectedRepository: selectedRepository.asDriver(onErrorDriveWith: .empty()),
            searchDescription: searchDescription.asDriver(onErrorDriveWith: .empty())
        )
    }
}
