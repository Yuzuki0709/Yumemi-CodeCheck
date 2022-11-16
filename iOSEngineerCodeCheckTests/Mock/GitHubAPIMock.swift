import Foundation
import RxSwift

@testable import iOSEngineerCodeCheck

final class GitHubAPIMock {
    let error: Error?
    
    init(error: Error? = nil) {
        self.error = error
    }
}
