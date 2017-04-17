import XCTest
import SwiftyJSON
@testable import eokoe_ios

class UsersModelFromJSONTests: XCTestCase {
  var validJSON: JSON!
  var validJSONUserDataEmpty: JSON!
  var invalidJSONUserWrongKeys: JSON!
  var invalidJSON: JSON!
  
  override func setUp() {
    super.setUp()
    
    validJSON = loadFile(name: "JSONUsers")
    XCTAssertNotNil(validJSON)
    
    validJSONUserDataEmpty = loadFile(name: "JSONUserDataEmpty")
    XCTAssertNotNil(validJSONUserDataEmpty)
    
    invalidJSONUserWrongKeys = loadFile(name: "JSONUserWrongKeys")
    XCTAssertNotNil(invalidJSONUserWrongKeys)
    
    invalidJSON = loadFile(name: "JSONWithoutKeyResultsAndPagination")
    XCTAssertNotNil(invalidJSON)
  }
  
  func testValidCases() {
    let pageIndex = buildPageIndex(json: validJSON)
    XCTAssert(pageIndex?.start == 20, "validJSON: pageIndex should have start: 20")
    XCTAssert(pageIndex?.limit == 20, "validJSON: pageIndex should have limit: 20")
    
    let users = buildUsers(json: validJSON)
    XCTAssert(users.count == 20, "validJSON: should have 20 users")
  }
  
  func testInvalidCases() {
    let pageIndex = buildPageIndex(json: invalidJSON)
    XCTAssertNil(pageIndex, "invalidJSON: pageIndex should be nil")
    
    let users = buildUsers(json: invalidJSON)
    XCTAssert(users.count == 0, "invalidJSON: should have 0 users")
    
    let usersWithEmptyFields = buildUsers(json: validJSONUserDataEmpty)
    XCTAssert(usersWithEmptyFields.count == 0, "JSONUserDataEmpty: should have 0 users")
    
    let usersWithWrongKeys = buildUsers(json: invalidJSONUserWrongKeys)
    XCTAssert(usersWithWrongKeys.count == 0, "JSONUserWrongKeys: should have 0 users")
  }
  
  private func loadFile(name: String) -> JSON? {
    guard let path = Bundle.main.path(forResource: name, ofType:"json") else {
      XCTFail("Invalid filename: \(name)")
      return nil
    }
    
    let jsonData = try? NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
    let json = JSON(data: jsonData as! Data)
    
    guard json != JSON.null else {
      XCTFail("Invalid JSON file: \(json)")
      return nil
    }
    
    return json
  }
}

extension UsersModelFromJSONTests: UsersModelsFromJSON {}
