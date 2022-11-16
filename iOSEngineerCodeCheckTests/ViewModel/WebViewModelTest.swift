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
    
    /// ロードが終わった時に、loadFinishに値が流れることを確認するテスト
    func testLoadFinish() {
        let loadFinish = scheduler.createObserver(Void.self)
        
        scheduler
            .createHotObservable([.next(10, WKNavigation())])
            .bind(to: didFinishLoad)
            .disposed(by: disposeBag)
        
        output.loadFinish
            .drive(loadFinish)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(loadFinish.events[0].time, TestTime(10))
        XCTAssertEqual(loadFinish.events.count, 1)
    }
    
    /// ロードが失敗した時に、loadFailにエラーが流れることを確認するテスト
    func testLoadFail() {
        XCTContext.runActivity(named: "不正なURL") { _ in
            let loadFail = scheduler.createObserver(WebLoadError.self)
            
            viewModel = WebViewModel()
            output    = viewModel.transform(input: input)
            
            output.loadFail
                .drive(loadFail)
                .disposed(by: disposeBag)
            
            scheduler
                .createHotObservable([.next(10, (WKNavigation(), NSError(domain: "", code: -1000)))])
                .bind(to: didFailLoad)
                .disposed(by: disposeBag)
            
            scheduler.start()
            
            XCTAssertEqual(loadFail.events, [
                .next(10, WebLoadError.badURL)
            ])
        }
        
        // スケジューラをリセット
        scheduler = TestScheduler(initialClock: 0)
                
        XCTContext.runActivity(named: "通信エラー") { _ in
            let loadFail = scheduler.createObserver(WebLoadError.self)
            
            viewModel = WebViewModel()
            output    = viewModel.transform(input: input)
            
            output.loadFail
                .drive(loadFail)
                .disposed(by: disposeBag)
            
            scheduler
                .createHotObservable([.next(10, (WKNavigation(), NSError(domain: "", code: -1009)))])
                .bind(to: didFailLoad)
                .disposed(by: disposeBag)
            
            scheduler.start()
            
            XCTAssertEqual(loadFail.events, [
                .next(10, WebLoadError.notConnectedToInternet)
            ])
        }
    }
}
