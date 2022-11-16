import XCTest

final class RepositoryDetailPage: PageObject {
    
    private enum IDs {
        static let detailTableView = "detail_showdetail_tableview"
        static let homepageCell    = "detail_homepage_cell"
        static let readmeCell      = "detail_readme_cell"
    }
    
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
