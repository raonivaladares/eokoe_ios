import Foundation

struct UserDetailsViewModel {
  var userDetails: UserDetails
  
  init(userDetails: UserDetails){
      self.userDetails = userDetails
  }
  
  func getUserSetUpData() -> (String, String, String, String, URL)? {
    let name = "\(userDetails.firstName ?? "") \(userDetails.LastName ?? "")"
    let bio = userDetails.bio ?? ""
    let email = userDetails.email ?? ""
    let location = userDetails.location ?? ""
    let pictureURL: URL! = URL(string: userDetails.pictureURL)
    
    return (name, bio, email, location, pictureURL)
  }
}
