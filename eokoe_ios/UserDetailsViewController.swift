import UIKit

class UserDetailsViewController: UIViewController {
  
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  fileprivate var userID: Int!
  private var viewModel: UserDetailsViewModel!
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    requestUserDetails()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    scrollView.contentSize = CGSize(width: view.frame.size.width, height: scrollView.frame.size.width + bioLabel.frame.size.height + 15)
  }
  
  // MARK: Private methods
  private func requestUserDetails() {
    AlertHelper.showProgress()
    UserDetailsAPI.sharedInstance.getUserDetails(userID: userID) { result in
      switch result {
      case .success(let userDetails):
        self.viewModel = UserDetailsViewModel(userDetails: userDetails)
        self.buildUI()
      case .error(let title, let message):
        print("\(title): \(message)")
      }
      AlertHelper.hideProgress()
    }
  }
  
  private func buildUI() {
    if let userDetailsSetUp: (name: String, bio: String, email: String, location: String, pictureURL: URL) = viewModel.getUserSetUpData() {
      profileImageView.af_setImage(withURL: userDetailsSetUp.pictureURL)
      nameLabel.text = userDetailsSetUp.name
      bioLabel.text = userDetailsSetUp.bio
      emailLabel.text = userDetailsSetUp.email
      locationLabel.text = userDetailsSetUp.location
    }
  }
}

// MARK: Extensions
extension UserDetailsViewController: Injectable {
  typealias T = Int
  
  func inject(value: T) {
    userID = value
  }
}
