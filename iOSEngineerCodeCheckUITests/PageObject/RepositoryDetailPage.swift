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
    
    private var detailTableView: XCUIElement {
        return app.tables[IDs.detailTableView].firstMatch
    }
    
    private var homepageCell: XCUIElement {
        return self.detailTableView.cells[IDs.homepageCell].firstMatch
    }
    
    private var readmeCell: XCUIElement {
        return self.detailTableView.cells[IDs.readmeCell].firstMatch
    }
}

extension RepositoryDetailPage {
    var existsPage: Bool {
        return detailTableView.exists
    }
    
    var existsHomepageCell: Bool {
        return homepageCell.exists
    }
    
    var existsReadmeCell: Bool {
        return readmeCell.exists
    }
}
