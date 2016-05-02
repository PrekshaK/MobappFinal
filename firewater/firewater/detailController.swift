//
//  detailController.swift
//  firewater
//
//  Created by Preksha Koirala on 4/30/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import Foundation
import UIKit
import Social

class detailController: UIViewController{
    
    var detailObject: items!
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mNameLabel: UILabel!
    @IBOutlet weak var mDateLabel: UILabel!
    
    override func viewDidLoad() {

        //detailObject is set from the main ViewController
        //So we just set its values in detailViewcontroller on viewDidLoad
        
        mImageView.image = detailObject.image1;
        mNameLabel.text = detailObject.textmsg;
        print (detailObject.date)
        mDateLabel.text = detailObject.date;
        
        super.viewDidLoad();
    }
    
    
    //When user clicks on "Share" Button, the user is presented with all the 
    //applications eligible for sharing that are present in the device
    @IBAction func mShare(sender: AnyObject) {
        let activityViewController = UIActivityViewController(
            activityItems: [detailObject.textmsg as! NSString],
            applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    //When user clicks on "Share Facebook" button, it shares the textmsg to facebook
    // if the user has facebook app installed and is logged in
    //else shows an alert to suggest the user to login to facebook first
    @IBAction func mShareFb(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(detailObject.textmsg)
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    

    
}