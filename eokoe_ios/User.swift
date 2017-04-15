import Foundation

struct User {
  let id: Int!
  let firstName: String!
  let LastName: String!
  let miniBio: String!
  let pictureURL: String!
  
  init?(id: Int, firstName: String, lastName: String, miniBio: String, pictureURL: String) {
    guard id > 0 else {
      print("User init error: id invalid empty")
      return nil
    }
    
    guard !firstName.isEmpty else {
      print("User init article error: firstName empty")
      return nil
    }
    
    guard !lastName.isEmpty else {
      print("User initarticle error: lastName empty")
      return nil
    }
    
    guard !miniBio.isEmpty else {
      print("User init article error: miniBio empty")
      return nil
    }
    
    guard !miniBio.isEmpty else {
      print("User init article error: miniBio empty")
      return nil
    }
    
    guard !pictureURL.isEmpty else {
      print("User init article error: pictureURL empty")
      return nil
    }
    
    self.id = id
    self.firstName = firstName
    self.LastName = lastName
    self.miniBio = miniBio
    self.pictureURL = pictureURL
  }
}
