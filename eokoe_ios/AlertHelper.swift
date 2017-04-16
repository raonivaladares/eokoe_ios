import UIKit
import PKHUD

struct AlertHelper {
  static func message(viewController: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in completion?() }
    
    alertController.addAction(okAction)
    viewController.present(alertController, animated: true, completion: nil)
  }
  
  static func showProgress() {
    HUD.show(.progress)
  }
  
  static func hideProgress() {
    HUD.hide()
  }
}
