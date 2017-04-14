import UIKit
import AlamofireImage

class UsersCell: UITableViewCell {
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var miniBioLabel: UILabel!
  
  func build(name: String, miniBio: String, pictureURL: URL) {
    
    nameLabel.text = name
    miniBioLabel.text = miniBio
    thumbnailImageView.af_setImage(withURL: pictureURL)
  }
}

extension UsersCell: ReusableView {}
