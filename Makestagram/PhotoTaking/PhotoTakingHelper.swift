//
//  PhotoTakingHelper.swift
//  Makestagram
//
//  Created by Noah Frenkel on 6/28/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

// typealias allows us to declare what type of function in terms
// of parameters and return types we will use for a callback (think function pointers in C++)
typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper: NSObject {

    // This is the reference to the viewControl on which the helper class will display other view controllers
    weak var viewController: UIViewController!
    
    // This is the callback function, it must be in the form of the typealias above, the function this references
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback) {
        
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelector()
    }
    
    func showPhotoSourceSelector() {
        // Allow user to choose between photo lib and camera
        // .ActionSheet tells the controller to display from the bottom of the screen
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
        
        // Create and add cancel action to our UIAlertController
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Create and add "Add Photo from Library" action to our UIAlertController
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) in
            self.showImagePickerController(.PhotoLibrary)
        }
        alertController.addAction(photoLibraryAction)
        
        // Create and add "Take Photo with Camera" action to our UIALertController
        // ONLY IF a rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default) { (action) in
                self.showImagePickerController(.Camera)
            }
            alertController.addAction(cameraAction)
        }
        
        // Present the alert controller on the viewController referenced in at initialization
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

