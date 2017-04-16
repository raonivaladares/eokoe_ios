import Foundation

struct UserDetails {
  let firstName: String!
  let LastName: String!
  let bio: String!
  let email: String!
  let location: String!
  let pictureURL: String!
  
  init?(firstName: String, lastName: String, bio: String, email: String? = nil, location: String? = nil, pictureURL: String) {
    
    guard !firstName.isEmpty else {
      print("UserDetails init article error: section empty")
      return nil
    }
    
    guard !lastName.isEmpty else {
      print("UserDetails initarticle error: publishedAt empty")
      return nil
    }
    
    guard !bio.isEmpty else {
      print("UserDetails init article error: content empty")
      return nil
    }
    
    guard !pictureURL.isEmpty else {
      print("UserDetails init article error: content empty")
      return nil
    }
    
    if let email = email, !email.isEmpty {
      self.email = email
    } else {
      self.email = "NA"
    }
    
    if let location = location, !location.isEmpty {
      self.location = location
    } else {
      self.location = "NA"
    }
    
    self.firstName = firstName
    self.LastName = lastName
    self.bio = bio
    self.pictureURL = pictureURL
  }
}
