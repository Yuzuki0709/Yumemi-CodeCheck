import Foundation
import Moya

enum GitHubAPITarget {
    case repository(keyword: String)
    case readme(ownerName: String, repositoryName: String)
}

extension GitHubAPITarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repository:
            return "/search/repositories"
        case .readme(let ownerName, let repositoryName):
            return "/repos/\(ownerName)/\(repositoryName)/readme"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .repository, .readme:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .repository(let keyword):
            return .requestParameters(parameters: ["q": keyword], encoding: URLEncoding.default)
        case .readme:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

// テスト用のSampleDataを設定
extension GitHubAPITarget {
    var sampleData: Data {
        switch self {
        case .repository:
            return """
            {
                "total_count": 254623,
                "items": [
                    {
                        "id": 44838949,
                        "name": "swift",
                        "full_name": "apple/swift",
                        "owner": {
                            "login": "apple",
                            "avatar_url": "https://avatars.githubusercontent.com/u/10639145?v=4",
                        },
                        "description": "The Swift Programming Language",
                        "created_at": "2015-10-23T21:15:07Z",
                        "updated_at": "2022-11-05T12:13:09Z",
                        "homepage": "https://swift.org",
                        "size": 894323,
                        "stargazers_count": 61018,
                        "watchers_count": 61018,
                        "language": "C++",
                        "forks_count": 9807,
                        "open_issues_count": 6182,
                    },
                    {
                        "id": 790019,
                        "name": "swift",
                        "full_name": "openstack/swift",
                        "owner": {
                            "login": "openstack",
                            "avatar_url": "https://avatars.githubusercontent.com/u/324574?v=4"
                        },
                        "description": "OpenStack Storage (Swift). Mirror of code maintained at opendev.org.",
                        "created_at": "2010-07-22T01:50:07Z",
                        "updated_at": "2022-11-04T09:15:54Z",
                        "homepage": "https://opendev.org/openstack/swift",
                        "size": 65321,
                        "stargazers_count": 2343,
                        "watchers_count": 2343,
                        "language": "Python",
                        "forks_count": 1060,
                        "open_issues_count": 0,
                    }
                ]
            }
            """.data(using: .utf8)!
            
        case .readme:
            return """
            {
                "html_url": "https://github.com/apple/swift/blob/main/README.md"
            }
            """.data(using: .utf8)!
        }
    }
}
