//
//  ShareGalleryViewController.swift
//  Fandomm
//
//  Created by Simon Narang on 12/13/15.
//  Copyright © 2015 Simon Narang. All rights reserved.
//

import UIKit

class ShareGalleryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var GalleryView: UIImageView!
    @IBOutlet weak var pixyView: UIImageView!
    let imagePicker = UIImagePickerController()
    let redisClient:RedisClient = RedisClient(host:"localhost", port:6379, loggingBlock:{(redisClient:AnyObject, message:String, severity:RedisLogSeverity) in
        var debugString:String = message
        debugString = debugString.stringByReplacingOccurrencesOfString("\r", withString: "\\r")
        debugString = debugString.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
        print("Log (\(severity.rawValue)): \(debugString)")
    })
    @IBAction func GetIMG(sender: AnyObject) {
        performSegueWithIdentifier("segueSix", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            pixyView.contentMode = .ScaleAspectFit
            pixyView.image = pickedImage
         dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueSix" {
            let destViewContOne: ShareToFandomTableViewController = segue.destinationViewController as! ShareToFandomTableViewController
            destViewContOne.shareImage = self.pixyView.image!
        }else {
            print("there is an undocumented segue form the preferences tab")
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
