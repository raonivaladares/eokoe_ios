import XCTest
@testable import eokoe_ios

class UserDetailsTests: XCTestCase {
  let firstName = "firstName"
  let lastName = "lastName"
  let bio = "bio"
  let email = "email"
  let location = "location"
  let pictureURL = "pictureURL"
  
  func testInitSuccess() {
    let userDetails = UserDetails(firstName: firstName, lastName: lastName, bio: bio, email: email, location: location, pictureURL: pictureURL)
    XCTAssertNotNil(userDetails, "UserDetails model: fail init")
    
    let userDetailsEmailNil = UserDetails(firstName: firstName, lastName: lastName, bio: bio, email: nil, location: location, pictureURL: pictureURL)
    XCTAssertNotNil(userDetailsEmailNil, "UserDetails model: fail init")
    XCTAssert(userDetailsEmailNil?.email == "NA")
    
    let userDetailsEmailEmpty = UserDetails(firstName: firstName, lastName: lastName, bio: bio, email: "", location: location, pictureURL: pictureURL)
    XCTAssertNotNil(userDetailsEmailEmpty, "UserDetails model: fail init")
    XCTAssert(userDetailsEmailEmpty?.email == "NA")
    
    let userDetailsLocationNil = UserDetails(firstName: firstName, lastName: lastName, bio: bio, email: email, location: nil, pictureURL: pictureURL)
    XCTAssertNotNil(userDetailsLocationNil, "UserDetails model: fail init")
    XCTAssert(userDetailsLocationNil?.location == "NA")
    
    let userDetailsLocationEmpty = UserDetails(firstName: firstName, lastName: lastName, bio: bio, email: email, location: "", pictureURL: pictureURL)
    XCTAssertNotNil(userDetailsLocationEmpty, "UserDetails model: fail init")
    XCTAssert(userDetailsLocationEmpty?.location == "NA")
  }
  
  func testInitFail() {
    let userDetailsEmptyFirstName = UserDetails(firstName: "", lastName: lastName, bio: bio, email: email, location: location, pictureURL: pictureURL)
    XCTAssertNil(userDetailsEmptyFirstName, "User: success init with empty firstName")
    
    let userDetailsEmptyLastName = UserDetails(firstName: firstName, lastName: "", bio: bio, email: email, location: location, pictureURL: pictureURL)
    XCTAssertNil(userDetailsEmptyLastName, "User: success init with empty lastName")
    
    let userDetailsEmptyBio = UserDetails(firstName: firstName, lastName: lastName, bio: "", email: email, location: location, pictureURL: pictureURL)
    XCTAssertNil(userDetailsEmptyBio, "User: success init with empty miniBio")
    
    let userDetailsEmptyPictureUrl = UserDetails(firstName: firstName, lastName: lastName, bio: bio, email: email, location: location, pictureURL: "")
    XCTAssertNil(userDetailsEmptyPictureUrl, "User: success init with empty userEmpty")
  }
}
