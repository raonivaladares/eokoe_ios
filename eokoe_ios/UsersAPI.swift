import Foundation
import Alamofire
import SwiftyJSON

class UsersAPI {
  enum Result {
    case error(title: String, message: String)
    case success(users: [User], pageIndex: PageIndex?)
  }
  
  static let sharedInstance = UsersAPI()
  private var baseURL = "https://testmobiledev.eokoe.com"
  private var headers: [String: String] = [:]
  
  // MARK: Inits
  init(){
    headers["X-API-Key"] = "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35"    
  }
  
  func getUsers(completionHandler: @escaping (Result) -> Void) {
    let endPoint = "/users"
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
  
  func getUsersWithIndex(lastUserIndex: Int, completionHandler: @escaping (Result) -> Void) {
    let endPoint = "/users?start=\(lastUserIndex)&limit=20"
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
