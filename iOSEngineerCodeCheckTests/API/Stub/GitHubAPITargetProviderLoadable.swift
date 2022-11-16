import Moya

@testable import iOSEngineerCodeCheck

protocol GitHubAPITargetProviderLoadable {
    func load() -> MoyaProvider<GitHubAPITarget>
}
