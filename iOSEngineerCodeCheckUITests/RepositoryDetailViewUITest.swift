import XCTest

final class RepositoryDetailViewUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    /// 詳細画面にホームページセルと、READMEセルが表示されることを確認するテスト
    func testShowCells() {
        let repositoryDetailView = RepositorySearchPage(application: app).goToDetailView()
        
        _ = app.waitForExistence(timeout: 5)
        XCTAssertTrue(repositoryDetailView.existsHomepageCell)
        XCTAssertTrue(repositoryDetailView.existsReadmeCell)
    }
}
