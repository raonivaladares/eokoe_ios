import Foundation

struct PageIndex {
  var start: Int
  var limit: Int
  
  init?(start: Int, limit: Int) {
    
    guard start > 0 else {
      print("PageIndex init error: start is invalid")
      return nil
    }
    
    guard limit > 0 else {
      print("PageIndex init error: limit is invalid")
      return nil
    }
    
    self.start = start
    self.limit = limit
  }
}
