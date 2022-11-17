import XCTest
import Moya
import RxMoya
import RxSwift
import RxTest
import RxBlocking

@testable import iOSEngineerCodeCheck

final class GitHubAPITest: XCTestCase {
    var scheduler:  TestScheduler!
    var disposeBag: DisposeBag!
    var githubAPI:  GitHubAPI!
    var stub:       MoyaProvider<GitHubAPITarget>!
    
    override func setUp() {
        scheduler  = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testSearchRepositories() {
        XCTContext.runActivity(named: "正常に終了") { _ in
            stub      = GitHubAPITargetProvider.stub200.provider
            githubAPI = GitHubAPI(provider: stub)
            
            let repositories = try! githubAPI
                .searchRepositories(keyword: "Swift")
                .toBlocking()
                .first()!
            
            XCTAssertEqual(repositories.count, 2)
            
            XCTAssertEqual(repositories[0].id, 44838949)
            XCTAssertEqual(repositories[0].fullName, "apple/swift")
            
            XCTAssertEqual(repositories[1].id, 790019)
            XCTAssertEqual(repositories[1].fullName, "openstack/swift")
        }
        
        XCTContext.runActivity(named: "リクエストエラー") { _ in
            stub      = GitHubAPITargetProvider.stub404.provider
            githubAPI = GitHubAPI(provider: stub)
            
            let result = try! githubAPI
                .searchRepositories(keyword: "Swift")
                .materialize()
                .toBlocking()
                .first()!
            
            XCTAssertEqual(result.error as! APIClientError, .requestError)
            XCTAssertNil(result.element)
        }
    }
}
