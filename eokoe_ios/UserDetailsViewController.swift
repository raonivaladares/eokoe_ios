import UIKit

class UserDetailsViewController: UIViewController {
  
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  override func viewDidLoad() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true

  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    
    navigationController?.navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
  }
  
}
