import Foundation
import SwiftyJSON

protocol UserDetailsModelsFromJSON: class {}

extension UserDetailsModelsFromJSON {
  func buildUserDetails(json: JSON) -> UserDetails? {
    guard let firstName = json["name"]["first"].string else {
      print("buildUserDetails error: key firstName")
      return nil
    }
    
    guard let lastName = json["name"]["last"].string else {
      print("buildUserDetails error: key lastName")
      return nil
    }
    
    var bio: String?  = nil
    if let miniBio = json["bio"]["mini"].string {
      bio = miniBio
    }else if let fullBio = json["bio"]["full"].string {
      bio = fullBio
    }
    
    guard let hasBio = bio else {
      print("buildUserDetails error: key mini or full")
      return nil
    }
    
    guard let email = json["email"].string else {
      print("buildUserDetails error: key id")
      return nil
    }
    
    guard let location = json["location"]["city"].string else {
      print("buildUserDetails error: key id")
      return nil
    }
    
    guard let pictureURL = json["picture"]["medium"].string else {
      print("buildUserDetails error: key thumbnail")
      return nil
    }
    
    return UserDetails(firstName: firstName, lastName: lastName, bio: hasBio, email: email, location: location, pictureURL: pictureURL)
  }
}
