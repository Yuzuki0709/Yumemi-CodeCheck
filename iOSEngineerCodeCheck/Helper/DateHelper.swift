import Foundation

final class DateHelper {
    private let formatter: DateFormatter
    
    static let shared = DateHelper()
    
    private init() {
        self.formatter          = DateFormatter()
        self.formatter.calendar = Calendar(identifier: .gregorian)
        self.formatter.locale   = Locale(identifier: "jp_JP")
    }
}

extension DateHelper {
    
    /// DateをStringに変換する関数
    /// - Parameters:
    ///   - date: 変換するdate
    ///   - dateFormat: 変換するフォーマット
    /// - Returns: 変換後の文字列
    func formatToString(date: Date?, dateFormat: String = "yyyy/MM/dd") -> String {
        guard let date = date else { return "" }
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}
