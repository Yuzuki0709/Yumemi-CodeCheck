import Foundation
import Moya

@testable import iOSEngineerCodeCheck

struct StubGitHubAPITargetProviderStatus200: GitHubAPITargetProviderLoadable {
    func load() -> MoyaProvider<GitHubAPITarget> {
        let customEndpointClosure = { (target: GitHubAPITarget) -> Endpoint in
            Endpoint(url: URL(target: target).absoluteString,
                     sampleResponseClosure: { .networkResponse(200, target.sampleData)},
                     method: target.method,
                     task: target.task,
                     httpHeaderFields: target.headers)
        }
        
        return MoyaProvider<GitHubAPITarget>(endpointClosure: customEndpointClosure,
                                             stubClosure: MoyaProvider.immediatelyStub)
    }
}

struct StubGitHubAPITargetProviderStatus404: GitHubAPITargetProviderLoadable {
    func load() -> MoyaProvider<GitHubAPITarget> {
        let customEndpointClosure = { (target: GitHubAPITarget) -> Endpoint in
            Endpoint(url: URL(target: target).absoluteString,
                     sampleResponseClosure: { .networkResponse(404, Data())},
                     method: target.method,
                     task: target.task,
                     httpHeaderFields: target.headers)
        }
        
        return MoyaProvider<GitHubAPITarget>(endpointClosure: customEndpointClosure,
                                             stubClosure: MoyaProvider.immediatelyStub)
    }
}
