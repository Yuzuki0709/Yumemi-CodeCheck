import Foundation

public struct GitHubReadme: Codable {
    public let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case htmlURL = "html_url"
    }
}
