import Foundation

public struct SearchResponse<Item: Decodable>: Decodable {
    public let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
