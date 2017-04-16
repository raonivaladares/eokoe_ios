import UIKit

protocol TransparentNavigationBar: class {}

extension TransparentNavigationBar where Self: UIViewController {
  func setupNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
}
