//
//  ViewController.swift
//  Fandomm
//
//  Created by weel Narang on 8/25/15.
//  Copyright © 2015 Simon Narang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var realUsername = String()
    var signUpCounter = 0
   
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(signUpCounter)
        // Do any additional setup after loading the view, typically from a nib.
        signUpCounter = 0
        self.username.autocapitalizationType = UITextAutocapitalizationType.None
        func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
            
            if let _ = string.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet()) {
                // Do not allow upper case letters
                return false
            }
            
            return true
        }
        
    }
    @IBAction func nextButton(sender: AnyObject) {
    let redisClient:RedisClient = RedisClient(host:"localhost", port:6379, loggingBlock:{(redisClient:AnyObject, message:String, severity:RedisLogSeverity) in
            var debugString:String = message
            debugString = debugString.stringByReplacingOccurrencesOfString("\r", withString: "\\r")
            debugString = debugString.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
            print("Log (\(severity.rawValue)): \(debugString)")
    })
        /*let request = NSMutableURLRequest(URL: NSURL(string: "https://fandomserver-herro.rhcloud.com")!)
        request.HTTPMethod = "POST"
        let postString: String = "username=\(username.text)&password=\(password.text)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task!.resume()*/
        let passwordUsernameSwitchErrorAlertOne = UIAlertController (title: "😂looks like you may have switched up your username and password😂", message: "if you are \(self.password.text!), want to login", preferredStyle: .Alert)
        let passwordUsernameSwitchErrorAlertOneOkButton = UIAlertAction(title: "sure!", style: .Default) { (action) in
        self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
        }
        passwordUsernameSwitchErrorAlertOne.addAction(passwordUsernameSwitchErrorAlertOneOkButton)
        let passwordUsernameSwitchErrorAlertOneNotMeButton = UIAlertAction(title: "thats not me let me try to sign in again", style: .Default) { (action) in}
        passwordUsernameSwitchErrorAlertOne.addAction(passwordUsernameSwitchErrorAlertOneNotMeButton)
        let networkErrorAlertTwo = UIAlertController(title: "😁having some trouble recognizing usernames right now😁", message: "i cant reach the chest full of gold usernames... either your not connected to the internet or you need to update fandom over in the app store if not im already working on a fix so try again soon", preferredStyle: .Alert)
        let networkErrorAlertTwoOkButton = UIAlertAction(title: "☹️okay☹️", style: .Default) { (action) in}
        networkErrorAlertTwo.addAction(networkErrorAlertTwoOkButton)

        let networkErrorAlertOne = UIAlertController(title: "😁having some trouble recognizing usernames right now😁", message: "sorry about that... perhaps check the app store to see if you need to update fandom... if not im already working on a fix so try again soon", preferredStyle: .Alert)
        let networkErrorAlertOneOkButton =  UIAlertAction(title: "☹️okay☹️", style: .Default) { (action) in
        }
        networkErrorAlertOne.addAction(networkErrorAlertOneOkButton)
        let loginErrorAlertOne = UIAlertController(title: "😜wrong password!😜", message: "try again \(self.username.text!)", preferredStyle: .Alert)
        let loginErrorAlertOneOkButton = UIAlertAction(title: "got it!", style: .Default) { (action) in
            }
        loginErrorAlertOne.addAction(loginErrorAlertOneOkButton)
        
        let signInOrUpAlertOne =  UIAlertController(title: "🤔don't recongnize that username!🤔", message: "did you mean to use another username or signup? ", preferredStyle: .Alert)
        let signInOrUpAlertOneSignUpButton = UIAlertAction(title: "sign up", style: .Default) { (action) in
            redisClient.lPush(self.username.text!, values: [self.password.text!], completionHandler: { (int, error) -> Void in
                if error != nil {
                    print("an error occured while attempting to sign up a user via lPush(PW/POSTS list)...")
                    print(error)
                    self.presentViewController(networkErrorAlertOne, animated: true) {}

                }else{
                    print("there was no error appending a user acount to the redis db via lpush")
                    self.signUpCounter += 1
                    print("no error... signUpCounter is now at \(self.signUpCounter)")
                }
            })
            redisClient.lPush("\(self.username.text!)followers", values: ["claire"], completionHandler: { (int, error) -> Void in
                if error != nil {
                    print("an error occured while attempting to sign up a user via lPush(FOLLOWERS list)...")
                    print(error)
                }else{
                    self.signUpCounter += 1

                }
            })
            redisClient.lPush("\(self.username.text!)following", values: ["claire"], completionHandler: { (int, error) -> Void in
                if error != nil {
                    print("an error occured while attempting to sign up a user via lPush(FOLLOWING list)...")
                    print(error)
                }else{
                    self.signUpCounter += 1
                }
            })
            redisClient.lPush("\(self.username.text!)fandoms", values: ["thefandomfandom"], completionHandler: { (int, error) -> Void in
                if error != nil {
                    print("an error occured while attempting to sign up a user via lPush(FANDOMS list)...")
                    print(error)
                }else{
                    self.signUpCounter += 1
                }
            })
            if self.signUpCounter == 4 {
                self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
            }else{
                if self.signUpCounter == 0{
                    print("all 4 of the tasks acossiated with user signup failed")
                    //self.presentViewController(networkErrorAlertOne, animated: true) {}
                    self.realUsername = self.username.text!
                    self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                }else if self.signUpCounter == 1 {
                    print("3 of the tasks acossiated with user signup failed")
                    //self.presentViewController(networkErrorAlertOne, animated: true) {}
                    self.realUsername = self.username.text!
                    self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                }else if self.signUpCounter == 2 {
                    print("2 of the tasks acossiated with user signup failed")
                    //self.presentViewController(networkErrorAlertOne, animated: true) {}
                    self.realUsername = self.username.text!
                    self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                }else if self.signUpCounter == 3{
                    print("1 of the tasks acossiated with user signup failed")
                    //self.presentViewController(networkErrorAlertOne, animated: true) {}
                    self.realUsername = self.username.text!
                    self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                }else{
                    print("FATAL ERR// something wrong with signup counter")
                    //self.presentViewController(networkErrorAlertOne, animated: true) {}
                    self.realUsername = self.username.text!
                    self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                }
            }
        }
        signInOrUpAlertOne.addAction(signInOrUpAlertOneSignUpButton)
        let signInOrUpAlertOneSignInButton = UIAlertAction(title: "use different username", style: .Default) { (action) in
        }
        signInOrUpAlertOne.addAction(signInOrUpAlertOneSignInButton)
        
        
        
        
        /*redisClient.auth("", completionHandler: { (string, error) -> Void in
            if error == nil {
                authenticated = (string == "OK")
                print("authenticated")
            }
            print("error is \(error)")
            if authenticated{
            }else{
                redisClient.quit { (string, error) -> Void in }
            }
        })*/
        //check to see if username already exists
        redisClient.exists(username.text!) { (int, error) -> Void in
            //if it does exist, and there is no error continue to check is password is correct
            if error == nil && int == 1 {
                print("omggg!!! the redis db didnt give an error for no reason!!! it worked!!!")
                self.realUsername = self.username.text!
                redisClient.lRange(self.username.text!, start: 0, stop: 0, completionHandler: { (array, error) -> Void in
                    if array[0] as? String == self.password.text {
                        self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                        print("testOne")
                        self.realUsername = self.username.text!
                    }else{
                        self.presentViewController(loginErrorAlertOne, animated: true) {}
                    }
                })
            }else if error == nil && int == 0 {
                print("zerow")
                redisClient.exists(self.password.text!, completionHandler: { (int, error) -> Void in
                    if error == nil && int == 1 {
                        redisClient.lRange(self.password.text!, start: 0, stop: 0, completionHandler: { (array, error) -> Void in
                            if array[0] as? String == self.username.text! {
                                self.presentViewController(passwordUsernameSwitchErrorAlertOne, animated: true) {}
                                self.realUsername = self.password.text!
                            }else{
                                self.presentViewController(signInOrUpAlertOne, animated: true) {}
                            }
                        })
                    }else{
                        self.presentViewController(signInOrUpAlertOne, animated: true) {}
                    }
                })
                
            }else{
                if int != nil {
                    self.presentViewController(networkErrorAlertOne, animated: true) {}
                    print("same old redis error :p")
                    print(error)
                }else{
                    self.presentViewController(networkErrorAlertTwo, animated: true) {}
                }
                
            }
            redisClient.quit { (string, error) -> Void in }
        }
        /*redisClient.set(username.text!, value: password.text!, setType: .Default) { (string, error) -> Void in
            if error != nil && string == "OK" {
                print("success")
                self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
            }
            else {
                self.performSegueWithIdentifier("viewControllerToTBVC", sender: nil)
                print("error storing string")
            }
            redisClient.quit { (string, error) -> Void in }
        }*/
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewCont: TabBarViewController = segue.destinationViewController as! TabBarViewController
        DestViewCont.usernameTwo = self.realUsername
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

