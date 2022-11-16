import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import iOSEngineerCodeCheck

final class RepositoryDetailViewModelTest: XCTestCase {
    var scheduler:       TestScheduler!
    var disposeBag:      DisposeBag!
    var viewWillAppear:  PublishRelay<Void>!
    var tableCellTapped: PublishRelay<IndexPath>!
    var viewModel:       RepositoryDetailViewModel!
    var input:           RepositoryDetailViewModel.Input!
    var output:          RepositoryDetailViewModel.Output!
}
