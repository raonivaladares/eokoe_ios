import UIKit

class UsersTableViewController: UITableViewController {
  
  var viewModel: UsersViewModel?

  // MARK: View life-cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    AlertHelper.showProgress()
    UsersAPI.sharedInstance.getUsers() { result in
      switch result {
      case .success(let users): self.viewModel = UsersViewModel(users: users)
        
      case .error(let title, let message):
        print("\(title): \(message)")
      }
      AlertHelper.hideProgress()
    }
  }
  
  // MARK: Segue
  
  // MARK: Private methods
}

// MARK: Extensions
extension UsersTableViewController {
}
