import Foundation

class UsersViewModel {
  private var users: [User]!
  var cellsQuantity: Int! {
    return users.count
  }
  private var pageIndex: PageIndex?
  var lastUserIndex: Int? {
    return pageIndex?.start
  }
  
  var userIDSelected: Int?
  
  init(users: [User], pageIndex: PageIndex?) {
    self.users = users
    self.pageIndex = pageIndex
  }
  
  func getCellSetUpData(index: Int) -> (String, String, URL)? {
    guard 0 <= index && index < users.count else {
      print("getCellSetUpData: index out of bound")
      return nil
    }
    
    let user = users[index]
    let name = "\(user.firstName ?? "") \(user.LastName ?? "")"
    let miniBio = user.miniBio ?? ""
    let pictureURL: URL! = URL(string: user.pictureURL)
    
    return (name, miniBio, pictureURL)
  }
  
  func setUserSelected(indexPath: IndexPath) {
    userIDSelected = users[indexPath.row].id
  }
  
  func update(newUsers: [User], pageIndex: PageIndex?) {
    for item in newUsers {
      users.append(item)
    }
    self.pageIndex = pageIndex
  }
}
