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
