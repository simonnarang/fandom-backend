//
//  TabBarViewController.swift
//  Fandomm
//
//  Created by Simon Narang on 11/29/15.
//  Copyright © 2015 Simon Narang. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    var usernameTwo = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataTransferViewControllerOne = (self.viewControllers?[0] as! UINavigationController).viewControllers[0] as! FeedTableViewController
        dataTransferViewControllerOne.usernameTwoTextOne = usernameTwo
        
        let dataTransferViewControllerTwo = (self.viewControllers?[1] as! UINavigationController).viewControllers[0] as! SearchTableViewController
        dataTransferViewControllerTwo.usernameTwoTextTwo = usernameTwo
        
        let dataTransferViewControllerThree = (self.viewControllers?[2] as! UINavigationController).viewControllers[0] as! PostViewController
        dataTransferViewControllerThree.usernameTwoTextThree = usernameTwo

        let dataTransferViewControllerFour = (self.viewControllers?[3] as! UINavigationController).viewControllers[0] as! ProfileViewController
        dataTransferViewControllerFour.usernameTwoTextFour = usernameTwo
        
        let dataTransferViewControllerFive = (self.viewControllers?[4] as! UINavigationController).viewControllers[0] as! PreferecesTableViewController
        dataTransferViewControllerFive.userameTwoTextFive = usernameTwo

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
