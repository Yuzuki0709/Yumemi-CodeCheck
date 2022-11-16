import XCTest

final class RepositoryDetailPage: PageObject {
    
    private let app: XCUIApplication
    
    required init(application: XCUIApplication) {
        self.app = application
    }
}

extension RepositoryDetailPage {
    var existsPage: Bool {
        return true
    }
}
