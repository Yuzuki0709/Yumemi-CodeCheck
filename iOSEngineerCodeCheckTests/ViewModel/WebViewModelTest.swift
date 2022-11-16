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
}
