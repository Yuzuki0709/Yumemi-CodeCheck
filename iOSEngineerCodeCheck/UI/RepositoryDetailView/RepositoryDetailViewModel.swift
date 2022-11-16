import Foundation
import RxSwift
import RxCocoa

final class RepositoryDetailViewModel {
    private let disposeBag = DisposeBag()
    
    private let repository: GitHubRepository
    
    init(repository: GitHubRepository) {
        self.repository = repository
    }
}
