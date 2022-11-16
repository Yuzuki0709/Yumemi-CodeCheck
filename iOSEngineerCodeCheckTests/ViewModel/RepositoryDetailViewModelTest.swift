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
    
    /// ホームページとREADMEの有無を正しく判別できることを確認するテスト
    func testIsExistCell() {
        XCTContext.runActivity(named: "両方存在する場合") { _ in
            let isExistHomepage = scheduler.createObserver(Bool.self)
            let isExistReadme   = scheduler.createObserver(Bool.self)
            
            viewModel = RepositoryDetailViewModel(
                repository: RepositorySampleData.appleRepository,
                githubAPI: GitHubAPIMock()
            )
            output    = viewModel.transform(input: input)
            
            output.isExistHomepage
                .drive(isExistHomepage)
                .disposed(by: disposeBag)
            
            output.isExistReadme
                .drive(isExistReadme)
                .disposed(by: disposeBag)
            
            viewWillAppear(time: 10)
            
            scheduler.start()
            
            XCTAssertEqual(isExistHomepage.events, [
                .next(0, false),  // BehaviorRelayのため、購読時にfalseが流れる
                .next(10, true)
            ])
            
            XCTAssertEqual(isExistReadme.events, [
                .next(0, false),  // 上記と同じ
                .next(10, true)
            ])
        }
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
