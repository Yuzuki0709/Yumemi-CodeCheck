import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    static func make(url: URL) -> WebViewController {
        let view = WebViewController.instantiate(storyboardName: "WebView")
        view.url = url
        return view
    }
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndecatorView: UIActivityIndicatorView!
    
    private var url: URL!
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: StoryboardInstantiable {}
