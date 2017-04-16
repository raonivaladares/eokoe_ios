import UIKit

protocol PhotoPickerDelegate {
  func handlerSelected(selected: UIImage?, name: String?)
}

class PhotoPicker: NSObject, UIImagePickerControllerDelegate {
  private var pickerController = UIImagePickerController()
  private var viewController: UIViewController!
  
  var photoPickerDelegate : PhotoPickerDelegate!
  
  // MARK: Init
  init(viewController: UIViewController) {
    super.init()
    self.viewController = viewController
    pickerController.delegate = self
  }
  
  // MARK: Public methods
  func callActionMenu(sender: AnyObject) {
    let optionsMenu = UIAlertController(title: nil, message: "Anexar imagem", preferredStyle: .actionSheet)
    
    if let popoverController = optionsMenu.popoverPresentationController {
      popoverController.sourceView = sender as? UIView
      popoverController.sourceRect = sender.bounds
    }
    
    optionsMenu.addAction(UIAlertAction(title: "Tirar foto", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.openCamera()
    }))
    
    optionsMenu.addAction(UIAlertAction(title: "Galeria", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.openGallery()
    }))
    
    optionsMenu.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {
      (alert: UIAlertAction!) -> Void in
    }))
    
    viewController.present(optionsMenu, animated: true, completion: nil)
  }
  
  // MARK: Private methods
  private func openCamera() {
    guard UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) else {
      AlertHelper.message(viewController: viewController, title: "Atenção", message: "O dispositivo não possui câmera")
      return
    }
    
    pickerController.allowsEditing = false
    pickerController.sourceType = UIImagePickerControllerSourceType.camera
    pickerController.cameraCaptureMode = .photo
    pickerController.cameraDevice = .rear
    
    viewController.present(pickerController, animated: true, completion: nil)
  }
  
  private func openGallery() {
    pickerController.allowsEditing = false
    pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
    pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    viewController.present(pickerController, animated: true, completion: nil)
  }
  
  // MARK: Image Picker Controller
  internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    self.photoPickerDelegate.handlerSelected(selected: image, name: "temp.JPG")
    viewController.dismiss(animated:true, completion: nil)
  }
}

extension PhotoPicker: UIPopoverControllerDelegate, UINavigationControllerDelegate {}
