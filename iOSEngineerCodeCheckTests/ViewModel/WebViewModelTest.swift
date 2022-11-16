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
}
