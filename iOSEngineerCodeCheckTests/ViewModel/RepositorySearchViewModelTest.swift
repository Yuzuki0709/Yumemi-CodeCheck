import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import iOSEngineerCodeCheck

final class RepositorySearchViewModelTest: XCTestCase {
    var scheduler:          TestScheduler!
    var disposeBag:         DisposeBag!
    var searchText:         PublishRelay<String>!
    var searchButtonTapped: PublishRelay<Void>!
    var selectedRepository: PublishRelay<IndexPath>!
    var viewModel:          RepositorySearchViewModel!
    var input:              RepositorySearchViewModel.Input!
    var output:             RepositorySearchViewModel.Output!
}
