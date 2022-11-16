import Foundation

public struct GitHubRepository: Codable {
    public let id             : Int
    public let fullName       : String
    public let owner          : Owner
    public let description    : String?
    public let createdAt      : Date
    public let updatedAt      : Date
    public let homepage       : String?
    public let size           : Int
    public let stargazersCount: Int
    public let watchersCount  : Int
    public let language       : String?
    public let forksCount     : Int
    public let openIssuesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName        = "full_name"
        case owner
        case description
        case createdAt       = "created_at"
        case updatedAt       = "updated_at"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount   = "watchers_count"
        case language
        case forksCount      = "forks_count"
        case openIssuesCount = "open_issues_count"
    }
}

public struct Owner: Codable {
    public let login    : String
    public let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
