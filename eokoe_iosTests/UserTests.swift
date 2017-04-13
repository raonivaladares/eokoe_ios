import XCTest
@testable import eokoe_ios

class UserTests: XCTestCase {
  let id = 1
  let firstName = "firstName"
  let lastName = "lastName"
  let miniBio = "miniBio"
  let pictureURL = "pictureURL"
  
  func testInitSuccess() {
    let user = User(id: id, firstName: firstName, lastName: lastName, miniBio: miniBio, pictureURL: pictureURL)
    XCTAssertNotNil(user, "User model: fail init")
  }
  
  func testInitFail() {
    let userIDZero = User(id: 0, firstName: firstName, lastName: lastName, miniBio: miniBio, pictureURL: pictureURL)
    XCTAssertNil(userIDZero, "User: success init with id -> 0")
    
    let userIDNegative = User(id: -1, firstName: firstName, lastName: lastName, miniBio: miniBio, pictureURL: pictureURL)
    XCTAssertNil(userIDNegative, "User: success init with id -> -1")
    
    let userEmptyFirstName = User(id: id, firstName: "", lastName: lastName, miniBio: miniBio, pictureURL: pictureURL)
    XCTAssertNil(userEmptyFirstName, "User: success init with empty firstName")
    
    let userEmptyLastName = User(id: id, firstName: firstName, lastName: "", miniBio: miniBio, pictureURL: pictureURL)
    XCTAssertNil(userEmptyLastName, "User: success init with empty lastName")

    let userEmptyMiniBio = User(id: id, firstName: firstName, lastName: lastName, miniBio: "", pictureURL: pictureURL)
    XCTAssertNil(userEmptyMiniBio, "User: success init with empty miniBio")

    let userEmptyPictureUrl = User(id: id, firstName: firstName, lastName: lastName, miniBio: miniBio, pictureURL: "")
    XCTAssertNil(userEmptyPictureUrl, "User: success init with empty userEmpty")
  }
}
