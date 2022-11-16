import XCTest

final class RepositorySearchViewUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    /// レポジトリを検索し、検索結果がテーブルに表示されることを確認するテスト
    func testSearchRepository() {
        let repositorySearchPage = RepositorySearchPage(application: app)
        
        repositorySearchPage.searchRepository(keyword: "Swift")
        
        _ = app.waitForExistence(timeout: 5)
        XCTAssertTrue(repositorySearchPage.existsCell)
    }
}
