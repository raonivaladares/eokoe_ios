import Foundation
import SwiftyJSON

protocol UsersModelsFromJSON: class {}

extension UsersModelsFromJSON {
  func buildUsers(json: JSON) -> [User] {
    var users: [User] = []
    
    guard let array = json["results"].array else {
      print("BuildUsers: there is no key: results")
      return users
    }
    
    for item in array {
      if let user = buildUser(json: item) {
        users.append(user)
      }
    }
    print("Total users builded: \(users.count) of \(array.count)")
    return users
  }
  
  private func buildUser(json: JSON) -> User? {
    guard let id = json["id"].int else {
      print("buildUser error: key id")
      return nil
    }
    
    guard let firstName = json["name"]["first"].string else {
      print("buildUser error: key firstName")
      return nil
    }
    
    guard let lastName = json["name"]["last"].string else {
      print("buildUser error: key lastName")
      return nil
    }
    
    guard let miniBio = json["bio"]["mini"].string else {
      print("buildUser error: key miniBio")
      return nil
    }
    
    guard let pictureURL = json["picture"]["thumbnail"].string else {
      print("buildUser error: key thumbnail")
      return nil
    }
    
    return User(id: id, firstName: firstName, lastName: lastName, miniBio: miniBio, pictureURL: pictureURL)
  }
}
