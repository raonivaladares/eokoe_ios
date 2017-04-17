import UIKit

class UsersTableViewController: UITableViewController {
  
  var viewModel: UsersViewModel?
  var isRequesting = false
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestUsers()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
    tableView.tableFooterView = nil
  }
  
  // MARK: Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowUserDetailsSegue", let navigationController = segue.destination as? UINavigationController {
      let userID = viewModel?.userIDSelected ?? 0
      let viewController = navigationController.viewControllers.first as! UserDetailsViewController
      viewController.inject(value: userID)
    }
  }
  
  // MARK: Private methods
  private func requestUsers() {
    AlertHelper.showProgress()
    UsersAPI.sharedInstance.getUsers() { result in
      switch result {
      case .success(let users, let pageIndex):
        self.viewModel = UsersViewModel(users: users, pageIndex: pageIndex)
        self.tableView.reloadData()
      case .error(let title, let message):
        AlertHelper.message(viewController: self, title: title, message: message)
      }
      AlertHelper.hideProgress()
    }
  }
}

// MARK: Extensions
extension UsersTableViewController {  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.cellsQuantity ?? 0  
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.reuseIdentifier, for: indexPath) as! UsersCell
    
    if let cellSetupData: (name: String, miniBio: String, pictureURL: URL) = viewModel?.getCellSetUpData(index: indexPath.row) {
        cell.build(name: cellSetupData.name, miniBio: cellSetupData.miniBio, pictureURL: cellSetupData.pictureURL)
    } else {
      print("UsersTableViewController: Error on row: \(indexPath.row)")
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel?.setUserSelected(indexPath: indexPath)
    performSegue(withIdentifier: "ShowUserDetailsSegue", sender: nil)
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let quantity = viewModel?.cellsQuantity else {
      print("Erro on pagination: quantity of itens invalid")
      return
    }
    
    guard let lastUserIndex = viewModel?.lastUserIndex else {
      print("Erro on pagination: quantity of itens invalid")
      return
    }
    
    if (indexPath.row == quantity - 1) && !isRequesting  {
      isRequesting = true
      UsersAPI.sharedInstance.getUsers(lastUserIndex: lastUserIndex) { result in
        switch result {
        case .success(let users, let pageIndex):
          self.viewModel?.update(newUsers: users, pageIndex: pageIndex)
          self.tableView.reloadData()
        case .error(let title, let message):
          AlertHelper.message(viewController: self, title: title, message: message)
        }
        self.isRequesting = false
      }
    }
  }
}
