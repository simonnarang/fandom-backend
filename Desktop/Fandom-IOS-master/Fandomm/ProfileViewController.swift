//
//  ProfileViewController.swift
//  Fandomm
//
//  Created by Simon Narang on 11/21/15.
//  Copyright © 2015 Simon Narang. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {
    var usernameTwoTextFour = String()
    @IBOutlet weak var usernameTwo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let redisClient:RedisClient = RedisClient(host:"localhost", port:6379, loggingBlock:{(redisClient:AnyObject, message:String, severity:RedisLogSeverity) in
            var debugString:String = message
            debugString = debugString.stringByReplacingOccurrencesOfString("\r", withString: "\\r")
            debugString = debugString.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
            print("Log (\(severity.rawValue)): \(debugString)")
        })
        usernameTwo.text = usernameTwoTextFour
        
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
