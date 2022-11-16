import UIKit
import WebKit
import RxSwift
import RxCocoa

final class WebViewController: UIViewController {
    
    static func make(url: URL) -> WebViewController {
        let view = WebViewController.instantiate(storyboardName: "WebView")
        view.url = url
        return view
    }
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndecatorView: UIActivityIndicatorView!
    
    private var url: URL!
    
    private let viewModel  = WebViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: StoryboardInstantiable {}
