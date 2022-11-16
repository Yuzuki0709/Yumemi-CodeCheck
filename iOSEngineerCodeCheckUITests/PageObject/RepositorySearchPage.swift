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
}

extension RepositorySearchPage {
    var existsPage: Bool {
        return true
    }
}
