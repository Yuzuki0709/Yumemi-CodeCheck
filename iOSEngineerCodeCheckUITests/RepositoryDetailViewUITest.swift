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
    
    /// ホームページセルをタップした時に、ホームページが表示されることを確認するテスト
    func testGoToHomepage() {
        let repositoryDetailView = RepositorySearchPage(application: app).goToDetailView()
        
        _ = app.waitForExistence(timeout: 5)
        
        let homepageView = repositoryDetailView.goToHomepage()
        
        XCTAssertTrue(homepageView.existsPage)
    }
    
    /// READMEセルをタップした時に、READMEが表示されることを確認するテスト
    func testGoToReadmeView() {
        let repositoryDetailView = RepositorySearchPage(application: app).goToDetailView()
        
        _ = app.waitForExistence(timeout: 5)
        
        let readmeView = repositoryDetailView.goToReadme()
        
        XCTAssertTrue(readmeView.existsPage)
    }
}
