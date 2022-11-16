import XCTest

final class RepositorySearchPage: PageObject {
    
    private enum IDs {
        static let searchBar           = "search_searchword_searchbar"
        static let searchButton        = "Search"
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
    
    private var searchButton: XCUIElement {
        return app.buttons[IDs.searchButton].firstMatch
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
    
    func searchRepository(keyword: String) {
        searchBar.tap()
        searchBar.typeText(keyword)
        searchButton.tap()
    }
}

extension RepositorySearchPage {
    var existsPage: Bool {
        return repositoryTableView.exists
    }
    
    var existsCell: Bool {
        return firstCell.exists
    }
}
