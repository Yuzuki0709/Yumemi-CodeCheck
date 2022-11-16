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
    
    override func setUp() {
        scheduler  = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        viewWillAppear  = PublishRelay<Void>()
        tableCellTapped = PublishRelay<IndexPath>()
        
        input = RepositoryDetailViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            tableCellTapped: tableCellTapped.asObservable()
        )
    }
    
    private func viewWillAppear(time: TestTime) {
        scheduler
            .createHotObservable([.next(time, Void())])
            .bind(to: viewWillAppear)
            .disposed(by: disposeBag)
    }
    
    private func tableCellTap(time: TestTime, _ indexPath: IndexPath) {
        scheduler
            .createHotObservable([.next(time, indexPath)])
            .bind(to: tableCellTapped)
            .disposed(by: disposeBag)
    }
}
