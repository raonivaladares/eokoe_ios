import XCTest
@testable import eokoe_ios

class PageIndexTests: XCTestCase {
  let start = 20
  let limit = 20
  
  func testInitSuccess() {
    let pageIndex = PageIndex(start: start, limit: limit)
    XCTAssertNotNil(pageIndex, "PageIndex model: fail init")
  }
  
  func testInitFail() {
    let pageIndexStartZero = PageIndex(start: 0, limit: limit)
    XCTAssertNil(pageIndexStartZero, "PageIndex: success init with start -> 0")
    
    let pageIndexStartNegative = PageIndex(start: -20, limit: limit)
    XCTAssertNil(pageIndexStartNegative, "PageIndex: success init with start -> -20")
    
    let pageIndexLimitZero = PageIndex(start: start, limit: 0)
    XCTAssertNil(pageIndexLimitZero, "PageIndex: success init with limit -> 0")
    
    let pageIndexLimitNegative = PageIndex(start: start, limit: -20)
    XCTAssertNil(pageIndexLimitNegative, "PageIndex: success init with limit -> -20")
  }
}
