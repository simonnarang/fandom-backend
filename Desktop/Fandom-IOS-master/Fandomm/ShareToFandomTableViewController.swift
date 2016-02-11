//
//  ShareToFandomTableViewController.swift
//  Fandomm
//
//  Created by Simon Narang on 1/9/16.
//  Copyright © 2016 Simon Narang. All rights reserved.
//

import UIKit

class ShareToFandomTableViewController: UITableViewController {
    @IBOutlet weak var labell: UILabel!
    var counter = Int()
    let redisClient:RedisClient = RedisClient(host:"localhost", port:6379, loggingBlock:{(redisClient:AnyObject, message:String, severity:RedisLogSeverity) in
        var debugString:String = message
        debugString = debugString.stringByReplacingOccurrencesOfString("\r", withString: "\\r")
        debugString = debugString.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
        print("Log (\(severity.rawValue)): \(debugString)")
    })

    var usernameThreeTextOne = String()
    var shareImage: UIImage? = nil
    var shareLinky: String? = nil
    var fandomsArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let linkShareActionSheetMenu = UIAlertController(title: nil, message: "which fandoms do you want to share this with?", preferredStyle: .ActionSheet)
        let backAction = UIAlertAction(title: "back", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled Link Share")
        })
        linkShareActionSheetMenu.addAction(backAction)
        presentViewController(linkShareActionSheetMenu, animated: true) { () -> Void in
            self.redisClient.lRange("\(self.usernameThreeTextOne)fandoms", start: 0, stop: 999999, completionHandler: { (array, error) -> Void in
                if error != nil {
                    
                } else{
                    for fandom in array {
                        print(fandom)
                        self.counter += 1
                        let bla = UIAlertAction(title: fandom as? String, style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            print("bla")
                            if self.shareLinky != nil && self.shareImage == nil {
                                self.redisClient.lPush(fandom as! String, values: [self.shareLinky! as String], completionHandler: { (int, error) -> Void in
                                    if error != nil {
                                    
                                    }else{
                                        self.performSegueWithIdentifier("doneSharing", sender: nil)
                                    }
                                })
                            }else if self.shareLinky == nil && self.shareImage != nil {
                            }

            })

                        linkShareActionSheetMenu.addAction(bla)
                        
                    }
                }
            })
            self.counter = 0
        }
        counter = 0
        let networkErrorAlertOne = UIAlertController(title: "Network troubles...", message: "Sorry about that... Perhaps check the app store to see if you need to update fandom... If not I'm already working on a fix so try again soon", preferredStyle: .Alert)
        let networkErrorAlertOneOkButton =  UIAlertAction(title: "☹️okay☹️", style: .Default) { (action) in
        }
        networkErrorAlertOne.addAction(networkErrorAlertOneOkButton)
        let noFandomsErrorAlertOne = UIAlertController(title: "Youre not in any Fandoms!", message: "id recomend searching gor what your interested in and joining it!", preferredStyle: .Alert)
        let noFandomsErrorAlertOneOkButton =  UIAlertAction(title: "okay", style: .Default) { (action) in
        }
        let noFandomsErrorAlertOneOkButton2 =  UIAlertAction(title: "search", style: .Default) { (action) in
            self.performSegueWithIdentifier("segueSeven", sender: nil)
        }
        noFandomsErrorAlertOne.addAction(noFandomsErrorAlertOneOkButton)
        noFandomsErrorAlertOne.addAction(noFandomsErrorAlertOneOkButton2)
       /* redisClient.lRange("\(self.usernameThreeTextOne)fandoms", start: 0, stop: 99999999) { (array, error) -> Void in
            if error != nil {
                print(error)
                self.presentViewController(networkErrorAlertOne, animated: true) {}
            }else if array == nil {
                print("you have no friends because you have no fandoms")
                self.presentViewController(noFandomsErrorAlertOne, animated: true) {}
            }else if error == nil{
                print("jubs")
                print("\(self.usernameThreeTextOne)'s fandoms is/are \(array)")
                for fandom in array {
                    print(fandom)
                    self.counter += 1
                    self.fandomsArray.append(fandom as! String)
                    print("counter = \(self.counter)")
                    print("hi")
                }
                print("array of fandoms is \(self.fandomsArray)")
            }else{
            }
        }*/

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

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
        return counter
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*let cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell")
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let(fandomconstant) = fandomsArray[indexPath.row]
        cell!.textLabel?.text = fandomconstant
            print(fandomconstant)
            if cell == nil {
                print("wow")
                print("bad")
            }else{
        print("life")
            }
        return cell!*/
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = "Hello Man"
        cell.addSubview(label)
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

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
