//
//  ShareLinkViewController.swift
//  Fandomm
//
//  Created by Simon Narang on 11/29/15.
//  Copyright © 2015 Simon Narang. All rights reserved.
//

import UIKit

class ShareLinkViewController: UIViewController {
    var shareLinkk = String()
    var fandommcount = 0
    var usernameThreeTextOne = String()
    @IBOutlet weak var shareLink: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        fandommcount = 0
        // Do any additional setup after loading the view.
    }

    @IBAction func shareLinkButton(sender: AnyObject) {
        self.shareLinkk = self.shareLink.text!
        let linkShareActionSheetMenu = UIAlertController(title: nil, message: "which fandoms do you want to share this with?", preferredStyle: .ActionSheet)
        let backAction = UIAlertAction(title: "back", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled Link Share")
        })
        linkShareActionSheetMenu.addAction(backAction)
        let redisClient:RedisClient = RedisClient(host:"localhost", port:6379, loggingBlock:{(redisClient:AnyObject, message:String, severity:RedisLogSeverity) in
            var debugString:String = message
            debugString = debugString.stringByReplacingOccurrencesOfString("\r", withString: "\\r")
            debugString = debugString.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
            print("Log (\(severity.rawValue)): \(debugString)")
        })
        //self.presentViewController(linkShareActionSheetMenu, animated: true, completion: nil)
        performSegueWithIdentifier("segueThree", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueThree" {
            let destViewContOne: ShareToFandomTableViewController = segue.destinationViewController as! ShareToFandomTableViewController
            destViewContOne.usernameThreeTextOne = self.usernameThreeTextOne
            destViewContOne.shareLinky = self.shareLinkk
        }else {
            print("there is an undocumented segue form the post tab")
        }
        
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
