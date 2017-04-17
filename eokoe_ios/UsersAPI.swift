import Foundation
import Alamofire
import SwiftyJSON

class UsersAPI {
  enum Result {
    case error(title: String, message: String)
    case success(users: [User], pageIndex: PageIndex?)
  }
  
  static let sharedInstance = UsersAPI()
  
  // MARK: Public methods
  func getUsers(lastUserIndex: Int? = nil, completionHandler: @escaping (Result) -> Void) {
    let endPoint: String = "/users?start=\(lastUserIndex ?? 0)&limit=20"
    
    EokoeClient.sharedInstance.request(endPoint: endPoint) { response in
      switch response {
      case .success(let json):
        let users = self.buildUsers(json: json)
        let pageIndex = self.buildPageIndex(json: json)
        completionHandler(.success(users: users, pageIndex: pageIndex))
      case .error(let title, let message):
        completionHandler(.error(title: title, message: message))
      }
    }
  }
}

extension UsersAPI: UsersModelsFromJSON {}
