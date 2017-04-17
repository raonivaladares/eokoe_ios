import Foundation
import Alamofire
import SwiftyJSON

class EokoeClient {
  enum Result {
    case error(title: String, message: String)
    case success(response: JSON)
  }
  
  static let sharedInstance = EokoeClient()
  private var baseURL = "https://testmobiledev.eokoe.com"
  private var headers: [String: String] = [:]
  
  // MARK: Inits
  init(){
    headers["X-API-Key"] = "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35"
  }
  
  func request(url: String, completionHandler: @escaping (Result) -> Void) {
    Alamofire.request(url, headers: headers)
      .responseJSON { response in
        self.responseHandler(response: response, completionHandler: completionHandler)
    }
    
  }
  
  private func responseHandler(response: DataResponse<Any>, completionHandler: @escaping (Result) -> Void) {
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
    completionHandler(.success(response: json))
    }
}
