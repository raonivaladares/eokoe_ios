import XCTest
@testable import eokoe_ios

class UsersViewModelsTests: XCTestCase {
  let usersEmpty: [User] = []
  let usersSome: [User] = [User(id: 1, firstName: "firstName", lastName: "lastName", miniBio: "miniBio", pictureURL: "pictureURL")!]
  
  func testInitSuccess() {
    let viewModelUsersEmpty = UsersViewModel(users: usersEmpty)
    XCTAssertNotNil(viewModelUsersEmpty, "UsersViewModel model: fail init")
    
    let viewModelSome = UsersViewModel(users: usersSome)
    XCTAssertNotNil(viewModelSome, "UsersViewModel model: fail init")
  }
  
  func testInitFail() {
    
  }
}
