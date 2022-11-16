import XCTest

final class WebPage: PageObject {
    
    private let app: XCUIApplication
    
    required init(application: XCUIApplication) {
        self.app = application
    }
}

extension WebPage {
    var existsPage: Bool {
        return true
    }
}
