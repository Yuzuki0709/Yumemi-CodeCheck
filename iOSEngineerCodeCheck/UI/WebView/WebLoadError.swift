enum WebLoadError: Error {
    case badURL
    case notConnectedToInternet
    case unknown
    
    init(errorCode: Int) {
        switch errorCode {
        case -1000: self = .badURL
        case -1009: self = .notConnectedToInternet
        default:    self = .unknown
        }
    }
    
    func description() -> String {
        switch self {
        case .badURL:
            return "不正なURLです。"
        case .notConnectedToInternet:
            return "通信に失敗しました。"
        case .unknown:
            return "不明なエラー"
        }
    }
}
