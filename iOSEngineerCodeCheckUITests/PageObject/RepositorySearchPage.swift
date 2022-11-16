import XCTest

final class RepositorySearchPage: PageObject {
    private let app: XCUIApplication
    
    required init(application: XCUIApplication) {
        self.app = application
    }
}

extension RepositorySearchPage {
    var existsPage: Bool {
        return true
    }
}
