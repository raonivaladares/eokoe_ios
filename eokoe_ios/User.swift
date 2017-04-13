import Foundation

struct User {
  let id: Int!
  let firstName: String!
  let LastName: String!
  let miniBio: String!
  let pictureURL: String!
  
  init?(id: Int, firstName: String, lastName: String, miniBio: String, pictureURL: String) {
    guard id > 0 else {
      print("Article init error: title empty")
      return nil
    }
    
    guard !firstName.isEmpty else {
      print("Article init article error: section empty")
      return nil
    }
    
    guard !lastName.isEmpty else {
      print("Article initarticle error: publishedAt empty")
      return nil
    }
    
    guard !miniBio.isEmpty else {
      print("Article init article error: content empty")
      return nil
    }
    
    guard !miniBio.isEmpty else {
      print("Article init article error: content empty")
      return nil
    }
    
    guard !pictureURL.isEmpty else {
      print("Article init article error: content empty")
      return nil
    }
    
    self.id = id
    self.firstName = firstName
    self.LastName = lastName
    self.miniBio = miniBio
    self.pictureURL = pictureURL
  }
}
