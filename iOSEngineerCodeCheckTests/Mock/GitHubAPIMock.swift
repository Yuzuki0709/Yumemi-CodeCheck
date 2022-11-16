import Foundation
import RxSwift

@testable import iOSEngineerCodeCheck

final class GitHubAPIMock {
    let error: Error?
    
    init(error: Error? = nil) {
        self.error = error
    }
}

extension GitHubAPIMock: GitHubAPIProtocol {
    func searchRepositories(keyword: String) -> Observable<[GitHubRepository]> {
        if let error = error { return Observable.error(error) }
        return Observable.just(RepositorySampleData.expectedData)
    }
    
    func searchReadme(ownerName: String, repositoryName: String) -> Observable<GitHubReadme> {
        if let error = error { return Observable.error(error) }
        return Observable.just(ReadmeSampleData.appleReadme)
    }
}
