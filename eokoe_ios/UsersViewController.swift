import UIKit

class ViewController: UIViewController {
  var viewModel: UsersViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UsersAPI.sharedInstance.getUsers() { result in
      switch result {
      case .success(let users): self.viewModel = UsersViewModel(users: users)
        
      case .error(let title, let message):
        print("\(title): \(message)")
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

