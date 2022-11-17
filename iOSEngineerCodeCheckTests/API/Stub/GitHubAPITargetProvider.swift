import Moya

@testable import iOSEngineerCodeCheck

enum GitHubAPITargetProvider {
    case stub200
    case stub404
    
    var provider: MoyaProvider<GitHubAPITarget> {
        switch self {
        case .stub200:
            return StubGitHubAPITargetProviderStatus200().load()
        case .stub404:
            return StubGitHubAPITargetProviderStatus404().load()
        }
    }
}
