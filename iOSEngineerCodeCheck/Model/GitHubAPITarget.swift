import Foundation
import Moya

enum GitHubAPITarget {
    case repository(keyword: String)
}

extension GitHubAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repository:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .repository:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .repository(let keyword):
            return .requestParameters(parameters: ["q": keyword], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
