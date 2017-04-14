import Foundation

struct UsersViewModel {
  private let users: [User]!
  var cellsQuantity: Int {
    return users.count
  }
  
  init(users: [User]) {
    self.users = users
  }
  
  func getCellSetUpData(indexPath: IndexPath) -> (String, String, URL)! {
    let user = users[indexPath.row]
    let name = "\(user.firstName ?? "") \(user.LastName ?? "")"
    let miniBio = user.miniBio ?? ""
    let pictureURL: URL! = URL(string: user.pictureURL)
    
    return (name, miniBio, pictureURL)
  }
}
