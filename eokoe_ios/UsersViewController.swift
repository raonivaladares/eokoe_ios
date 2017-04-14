import UIKit

class UsersTableViewController: UITableViewController {
  
  var viewModel: UsersViewModel?
  
  // MARK: View life-cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestUsers()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
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
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.cellsQuantity ?? 0  
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.reuseIdentifier, for: indexPath) as! UsersCell
    
    if let cellSetupData: (name: String, miniBio: String, pictureURL: URL) = viewModel?.getCellSetUpData(indexPath: indexPath) {
        cell.build(name: cellSetupData.name, miniBio: cellSetupData.miniBio, pictureURL: cellSetupData.pictureURL)
    } else {
      print("UsersTableViewController: Error on row: \(indexPath.row)")
    }
    
    return cell
    
  }
  
}
