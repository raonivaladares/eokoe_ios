import Foundation
import Alamofire
import SwiftyJSON

class UserDetailsAPI {
  enum Result {
    case error(title: String, message: String)
    case success(response: UserDetails)
  }
  
  static let sharedInstance = UserDetailsAPI()
  private var baseURL = "https://testmobiledev.eokoe.com/user/"
  private var headers: [String: String] = [:]
  
  // MARK: Inits
  init(){
    headers["X-API-Key"] = "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35"
  }

  func getUserDetails(userID: Int, completionHandler: @escaping (Result) -> Void) {
    EokoeClient.sharedInstance.request(url: baseURL + userID.description) { response in
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

extension UserDetailsAPI: UserDetailsModelsFromJSON {}


