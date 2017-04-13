import UIKit
import PKHUD

struct AlertHelper {
  static func showProgress() {
    HUD.show(.progress)
  }
  
  static func hideProgress() {
    HUD.hide()
  }
}
