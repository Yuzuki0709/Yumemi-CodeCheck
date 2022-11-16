enum WebLoadError: Error {
    case badURL
    case notConnectedToInternet
    case unknown
    
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
