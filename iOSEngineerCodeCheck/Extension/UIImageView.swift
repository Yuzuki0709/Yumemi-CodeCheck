import UIKit

extension UIImageView {
    /// 画像を丸くする
    func clipCircle() {
        self.layer.cornerRadius = self.frame.width * 0.5
    }
}
