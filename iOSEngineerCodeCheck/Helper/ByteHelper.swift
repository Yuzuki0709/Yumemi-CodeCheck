import Foundation

final class ByteHelper {
    private let formatter: ByteCountFormatter
    
    static let shared = ByteHelper()
    
    private init() {
        self.formatter = ByteCountFormatter()
        self.formatter.countStyle = .file
    }
}
