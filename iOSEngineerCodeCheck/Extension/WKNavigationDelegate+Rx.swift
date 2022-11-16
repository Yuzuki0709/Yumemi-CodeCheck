import WebKit
import RxSwift

extension Reactive where Base: WKWebView {
    public var didFailProvisionalNavigation: Observable<(WKNavigation, Error)> {
        return self.navigationDelegate
            .methodInvoked(#selector(WKNavigationDelegate.webView(_:didFailProvisionalNavigation:withError:)))
            .map { args in
                let webview = args[1] as! WKNavigation
                let error   = args[2] as! Error
                
                return (webview, error)
            }
    }
}
