//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Noah Frenkel on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    var photoTakingHelper: PhotoTakingHelper?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting this class as the delegate for the tabBarController
        self.tabBarController?.delegate = self
    }
    
    func takePhoto() {
        
        // Instantiate a PhotoTakingHelper and provide the callback for when the photo is selected.
        // We pass the initializer the tabBarController because that is the controller for the root
        // view of our application. It is typically good practice to send alerts to the root view.
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
            // The "in" keyword signifies the start of a closure's code,
            // the stuff in parenthesis before it are the params that the closure takes
            // This is called a "trailing closure".
            print("recieved a callback")
        }
    }
}

// MARK: Tab Bar Delegate
// By extending TimelineViewController from UITabBarControllerDelegate, we allow our TimelineViewController class to
// take on some of the responsibilites for managing the UITabBarController's behaviour
extension TimelineViewController: UITabBarControllerDelegate {
    
    // Here we alter the functionality of the tab bar by specifying that if PhotoViewController is selected from the bar,
    // takePhoto() will run instead of trying to display the PhotoViewController
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        }
        else {
            return true
        }
    }
    
}
