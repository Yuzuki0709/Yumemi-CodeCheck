import XCTest

final class WebPage: PageObject {
    
    private enum IDs {
        static let webView = "web_showweb_webview"
    }
    
    private let app: XCUIApplication
    
    required init(application: XCUIApplication) {
        self.app = application
    }
    
    private var webView: XCUIElement {
        return app.webViews[IDs.webView].firstMatch
    }
}

extension WebPage {
    var existsPage: Bool {
        return webView.exists
    }
}
