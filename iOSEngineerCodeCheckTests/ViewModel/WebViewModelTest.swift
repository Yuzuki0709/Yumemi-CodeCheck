import XCTest
import WebKit
import RxSwift
import RxCocoa
import RxTest

@testable import iOSEngineerCodeCheck

final class WebViewModelTest: XCTestCase {
    var scheduler:     TestScheduler!
    var disposeBag:    DisposeBag!
    var didStartLoad:  PublishRelay<WKNavigation>!
    var didFinishLoad: PublishRelay<WKNavigation>!
    var didFailLoad:   PublishRelay<(WKNavigation, Error)>!
    var viewModel:     WebViewModel!
    var input:         WebViewModel.Input!
    var output:        WebViewModel.Output!
    
    override func setUp() {
        scheduler  = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        didStartLoad  = PublishRelay<WKNavigation>()
        didFinishLoad = PublishRelay<WKNavigation>()
        didFailLoad   = PublishRelay<(WKNavigation, Error)>()
        
        input = WebViewModel.Input(
            didStartLoad: didStartLoad.asObservable(),
            didFinishLoad: didFinishLoad.asObservable(),
            didFailLoad: didFailLoad.asObservable()
        )
        
        viewModel = WebViewModel()
        output    = viewModel.transform(input: input)
    }
    
    /// 画面が表示された時に、ロードが開始されることを確認するテスト
    func testLoading() {
        let loading = scheduler.createObserver(Void.self)
        
        scheduler
            .createHotObservable([.next(10, WKNavigation())])
            .bind(to: didStartLoad)
            .disposed(by: disposeBag)
        
        output.loading
            .drive(loading)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(loading.events[0].time, TestTime(10))
        XCTAssertEqual(loading.events.count, 1)
    }
}
