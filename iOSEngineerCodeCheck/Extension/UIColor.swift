import UIKit

extension UIColor {
    /// 16進数で初期化する
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let value = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(value / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(value / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(value / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
