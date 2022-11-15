import Foundation

enum APIClientError: Error {
    case requestError
    case serverError
    case maintenanceError
    case unknown
    
    init(statusCode: Int) {
        switch statusCode {
        case 400...499:
            self = .requestError
        case 501, 502, 504...599:
            self = .serverError
        case 503:
            self = .maintenanceError
        default:
            self = .unknown
        }
    }
}
