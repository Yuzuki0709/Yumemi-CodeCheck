import UIKit

protocol AlertDisplaying {
    func displayNormalAlert(title: String?, message: String?)
}

extension AlertDisplaying where Self: UIViewController {
    func displayNormalAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true)
    }
}
