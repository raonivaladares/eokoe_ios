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
  fileprivate var viewModel: UserDetailsViewModel!
  private var photoPicker: PhotoPicker!
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    photoPicker = PhotoPicker(viewController: self)
    photoPicker.photoPickerDelegate = self
    requestUserDetails()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
    navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.width + bioLabel.frame.size.height + emailLabel.frame.size.height + locationLabel.frame.height + 20)
  }
  
  @IBAction func sendImageAction(_ sender: UIButton) {
    photoPicker.callActionMenu(sender: sender)
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
        AlertHelper.message(viewController: self, title: title, message: message) {
          _ = self.navigationController?.popViewController(animated: true)
        }
      }
      AlertHelper.hideProgress()
    }
  }
  
  fileprivate func buildUI() {
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

extension UserDetailsViewController: PhotoPickerDelegate {
  func handlerSelected(selected: UIImage?, name: String?) {
    if let image = selected, let name = name  {
      if let data = UIImageJPEGRepresentation(image, 0.2) {
        let imageName = name
        let imageData = data
        print(name)
        print(image)
        AlertHelper.showProgress()
        UploadImageAPI.sharedInstance.uploadImage(imageName: imageName, imageData: imageData) { result in
          switch result {
          case .success(_):
            AlertHelper.message(viewController: self, title: "Foto enviada", message: "Sua foto foi enviada com sucesso!")
          case .error(let title, let message):
            AlertHelper.message(viewController: self, title: title, message: message)
          }
          AlertHelper.hideProgress()
        }
      }
    }
  }
}
