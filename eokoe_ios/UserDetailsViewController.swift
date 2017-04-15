import UIKit

class UserDetailsViewController: UIViewController {
  
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  var id: Int!
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    
    requestUserDetails()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
  }
  
  // MARK: Private methods
  private func requestUserDetails() {
    AlertHelper.showProgress()
    UserDetailsAPI.sharedInstance.getUserDetails() { result in
      switch result {
      case .success(let userDetails): break
      case .error(let title, let message):
        print("\(title): \(message)")
      }
      AlertHelper.hideProgress()
    }
  }
}

// MARK: Extensions
extension UserDetailsViewController: Injectable {
  typealias T = Int
  
  func inject(value: T) {
    id = value
  }
}
