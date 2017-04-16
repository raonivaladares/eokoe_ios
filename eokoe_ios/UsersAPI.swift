import Foundation
import Alamofire
import SwiftyJSON

class UsersAPI {
  enum Result {
    case error(title: String, message: String)
    case success(users: [User], pageIndex: PageIndex?)
  }
  
  static let sharedInstance = UsersAPI()
  private var baseURL = "https://testmobiledev.eokoe.com/users"
  private var headers: [String: String] = [:]
  
  // MARK: Inits
  init(){
    headers["X-API-Key"] = "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35"    
  }
  
  func getUsers(completionHandler: @escaping (Result) -> Void) {
    Alamofire.request(baseURL, headers: headers).responseJSON { response in
      guard response.result.isSuccess else {
        print("UsersAPI Error: \(response.result.error.debugDescription)")
        return completionHandler(.error(title: "Atenção", message: "Nossos servidores não estão respondendo, isso pode ser causado por uma fraca conexão ou um erro em nossos próprios servidores."))
      }
      
      guard let statusCode = response.response?.statusCode,
        statusCode >= 200 && statusCode <= 300,
        let data = response.data else {
          print("ContentAPI status code: \(response.response?.statusCode)")
          return completionHandler(.error(title: "Atenção", message: "Parece que os servidores estão um pouco instáveis, tente novamente em instantes."))
      }
      
      let json = JSON(data: data)
      let users = self.buildUsers(json: json)
      let pageIndex = self.buildPageIndex(json: json)
      
      completionHandler(.success(users: users, pageIndex: pageIndex))
    }
  }
  
  func getUsersWithIndex(lastUserIndex: Int, completionHandler: @escaping (Result) -> Void) {
    let endPoint = "?start=20&limit=20"
    Alamofire.request(baseURL + endPoint, headers: headers).responseJSON { response in
      guard response.result.isSuccess else {
        print("UsersAPI Error: \(response.result.error.debugDescription)")
        return completionHandler(.error(title: "Atenção", message: "Nossos servidores não estão respondendo, isso pode ser causado por uma fraca conexão ou um erro em nossos próprios servidores."))
      }
      
      guard let statusCode = response.response?.statusCode,
        statusCode >= 200 && statusCode <= 300,
        let data = response.data else {
          print("ContentAPI status code: \(response.response?.statusCode)")
          return completionHandler(.error(title: "Atenção", message: "Parece que os servidores estão um pouco instáveis, tente novamente em instantes."))
      }
      
      let json = JSON(data: data)
      let users = self.buildUsers(json: json)
      let pageIndex = self.buildPageIndex(json: json)
      
      completionHandler(.success(users: users, pageIndex: pageIndex))
    }
  }
}

extension UsersAPI: UsersModelsFromJSON {}
