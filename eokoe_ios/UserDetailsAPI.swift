import Foundation
import Alamofire
import SwiftyJSON

class UserDetailsAPI {
  enum Result {
    case error(title: String, message: String)
    case success(response: UserDetails)
  }
  
  static let sharedInstance = UserDetailsAPI()
  private var endPoint = "/user/"
  
  // MARK: Public methods
  func getUserDetails(userID: Int, completionHandler: @escaping (Result) -> Void) {
    EokoeClient.sharedInstance.request(endPoint: endPoint + userID.description) { response in
      switch response {
      case .success(let json):
        guard let userDetails = self.buildUserDetails(json: json) else {
          return completionHandler(.error(title: "Atenção", message: "Não estamos conseguindo ver as informações desse usuário, tente novamente em instantes"))
        }
        completionHandler(.success(response: userDetails))
      case .error(let title, let message):
        completionHandler(.error(title: title, message: message))
      }
    }
  }
}

// MARK: Extensions
extension UserDetailsAPI: UserDetailsModelsFromJSON {}


