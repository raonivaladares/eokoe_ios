import Foundation

struct UsersViewModel {
  private let users: [User]!
  var cellsQuantity: Int! {
    return users.count
  }
  
  init(users: [User]) {
    self.users = users
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
}
