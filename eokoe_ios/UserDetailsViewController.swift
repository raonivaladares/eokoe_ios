import UIKit

class UserDetailsViewController: UIViewController {
  
  override func viewDidLoad() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true

  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    
    navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
    navigationController?.navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
  }
  
}
