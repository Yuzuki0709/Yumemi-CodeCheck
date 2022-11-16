import XCTest

final class RepositorySearchPage: PageObject {
    
    private enum IDs {
        static let searchBar           = "search_searchresult_animationview"
        static let serachButton        = "Search"
        static let repositoryTableView = "search_repositorylist_tableview"
        static let animationView       = "search_searchresult_animationview"
    }
    
    private let app: XCUIApplication
    
    required init(application: XCUIApplication) {
        self.app = application
    }
    
    private var searchBar: XCUIElement {
        return app.otherElements[IDs.searchBar].firstMatch
    }
    
    private var repositoryTableView: XCUIElement {
        return app.tables[IDs.repositoryTableView].firstMatch
    }
    
    private var firstCell: XCUIElement {
        return self.repositoryTableView.children(matching: .cell).firstMatch
    }
    
    private var animationView: XCUIElement {
        return app.otherElements[IDs.animationView].firstMatch
    }
}

extension RepositorySearchPage {
    var existsPage: Bool {
        return true
    }
}
