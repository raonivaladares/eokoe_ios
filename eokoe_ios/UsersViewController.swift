import UIKit

class UsersTableViewController: UITableViewController {
  
  var viewModel: UsersViewModel?
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestUsers()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
    tableView.tableFooterView = nil
  }
  
  // MARK: Segue
  
  // MARK: Private methods
  private func requestUsers() {
    AlertHelper.showProgress()
    UsersAPI.sharedInstance.getUsers() { result in
      switch result {
      case .success(let users):
        self.viewModel = UsersViewModel(users: users)
        self.tableView.reloadData()
      case .error(let title, let message):
        print("\(title): \(message)")
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
    //viewModel?.setArticleSelected(indexPath: indexPath)
    performSegue(withIdentifier: "ShowUserDetailsSegue", sender: nil)
  }
}
