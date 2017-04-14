import XCTest
@testable import eokoe_ios

class UsersViewModelsTests: XCTestCase {
  var viewModelUsersEmpty: UsersViewModel!
  var viewModelSome: UsersViewModel!
  
  override func setUp() {
    let usersEmpty: [User] = []
    viewModelUsersEmpty = UsersViewModel(users: usersEmpty)
    
    
    let usersSome: [User] = [User(id: 1, firstName: "firstName", lastName: "lastName", miniBio: "miniBio", pictureURL: "pictureURL")!]
    viewModelSome = UsersViewModel(users: usersSome)
  }
  
  func testInit() {
    XCTAssertNotNil(viewModelUsersEmpty, "UsersViewModel model: fail init")
    XCTAssertNotNil(viewModelSome, "UsersViewModel model: fail init")
  }
  
  func testMethodsAttributes() {
    XCTAssert(viewModelUsersEmpty.cellsQuantity == 0, "viewModelUsersEmpty should have 0 of quantity")
    XCTAssert(viewModelSome.cellsQuantity == 1, "viewModelUsersEmpty should have 1 of quantity")
  }
  
  func testMethodsSuccess() {
    let cellSetUpData: (name: String, miniBio: String, pictureURL: URL)?  = viewModelSome.getCellSetUpData(index: 0)
    XCTAssertNotNil(cellSetUpData, "getCellSetUpData should return not be nil for a valid index")
    XCTAssert(cellSetUpData?.name == "firstName lastName")
    XCTAssert(cellSetUpData?.miniBio == "miniBio")
    XCTAssert(cellSetUpData?.pictureURL == URL(string: "pictureURL"))
  }
  
  func testMethodsFail() {
    let cellSetUpData = viewModelUsersEmpty.getCellSetUpData(index: 1)
    XCTAssertNil(cellSetUpData, "getCellSetUpData should return nil for a invalid index")
  }
}
