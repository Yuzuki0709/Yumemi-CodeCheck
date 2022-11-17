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
}
