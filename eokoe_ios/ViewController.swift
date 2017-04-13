import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    UsersAPI.sharedInstance.getUsers() { result in
      switch result {
      case .success(let response):
        print("Articles request succeess: \(response)")
        
        
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

