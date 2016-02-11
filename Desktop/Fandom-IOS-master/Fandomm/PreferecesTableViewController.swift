//
//  PreferecesTableViewController.swift
//  Fandomm
//
//  Created by Simon Narang on 11/21/15.
//  Copyright © 2015 Simon Narang. All rights reserved.
//

import UIKit

class PreferecesTableViewController: UITableViewController {
        var usernameTwoTextFour = String()
        override func viewDidLoad() {
        super.viewDidLoad()
        let redisClient:RedisClient = RedisClient(host:"localhost", port:6379, loggingBlock:{(redisClient:AnyObject, message:String, severity:RedisLogSeverity) in
            var debugString:String = message
            debugString = debugString.stringByReplacingOccurrencesOfString("\r", withString: "\\r")
            debugString = debugString.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
            print("Log (\(severity.rawValue)): \(debugString)")
        })
        
        // performSegueWithIdentifier("logOutSegue", sender: nil)
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func changePassword(sender: AnyObject) {
        performSegueWithIdentifier("changePassword", sender: nil)
            print("change PW screen opened")
    }
    @IBAction func changeusername(sender: AnyObject) {
        performSegueWithIdentifier("changeUsername", sender: nil)
            print("change username screen opened")
    }
    @IBAction func lougout(sender: AnyObject) {
        performSegueWithIdentifier("logOutSegue", sender: nil)
    }
    let preferencesButtonsStrings = ["edit your profile", "log out", "delete account", "developer settings"]

    var userameTwoTextFive = String()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
        //let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changePassword" {
            let destViewContOne: ChangePWViewController = segue.destinationViewController as! ChangePWViewController
            destViewContOne.usernameFourTextOne = self.usernameTwoTextFour
        }else if segue.identifier == "changeUsername" {
            let destViewContOne: ChangeUsernameViewController = segue.destinationViewController as! ChangeUsernameViewController
            destViewContOne.usernameFourTextTwo = self.usernameTwoTextFour
        }else {
            print("there is an undocumented segue form the preferences tab")
        }
        
    }

    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("preferencesCell", forIndexPath: indexPath)
        let preferenceString = preferencesButtonsStrings[indexPath.row]
        
        // Configure the cell...

        return cell
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
