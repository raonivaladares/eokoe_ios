import Foundation
import Alamofire
import SwiftyJSON

class UploadImageAPI {
  enum Result {
    case error(title: String, message: String)
    case success()
  }
  
  static let sharedInstance = UploadImageAPI()
  private var baseURL = "https://testmobiledev.eokoe.com/upload"
  private var headers: [String: String] = [:]
  
  // MARK: Inits
  init(){
    headers["X-API-Key"] = "d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35"
  }
  
  func uploadImage(imageName: String, imageData: Data, completionHandler: @escaping (Result) -> Void) {
    Alamofire.upload(
      multipartFormData: { multipartFormData in
        multipartFormData.append(imageData, withName: "image", fileName: imageName, mimeType: "image/png")
    },
      to: baseURL, headers: headers,
      encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
          upload.responseJSON { response in
            debugPrint(response)
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
            print(json)
            completionHandler(.success())
          }
        case .failure(let encodingError):
          print(encodingError)
          completionHandler(.error(title: "Atenção", message: "Parece que os servidores estão um pouco instáveis, tente novamente em instantes."))
        }
    })
  }
}



