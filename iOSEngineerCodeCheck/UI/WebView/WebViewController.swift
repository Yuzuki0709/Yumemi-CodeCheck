import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    static func make(url: URL) -> WebViewController {
        let view = WebViewController.instantiate(storyboardName: "WebView")
        view.url = url
        return view
    }
    
    private var url: URL!
}

extension WebViewController: StoryboardInstantiable {}
