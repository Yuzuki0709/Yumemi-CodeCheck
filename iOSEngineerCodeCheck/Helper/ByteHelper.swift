import Foundation

final class ByteHelper {
    private let formatter: ByteCountFormatter
    
    static let shared = ByteHelper()
    
    private init() {
        self.formatter = ByteCountFormatter()
        self.formatter.countStyle = .file
    }
}

extension ByteHelper {
    
    /// バイト数をフォーマットしてStringに変換する関数
    /// - Parameter byte: 変換するバイト
    /// - Returns: 変換後の文字列
    /// ex ) formatToString(byte: 6000) -> 6KB
    func formatToString(byte: Int64) -> String {
        formatter.string(fromByteCount: byte)
    }
}
