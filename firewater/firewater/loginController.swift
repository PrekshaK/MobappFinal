//
//  loginController.swift
//  firewater
//
//  Created by Preksha Koirala on 4/29/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class items{
    var image1: UIImage?
    var textmsg: String?
    var date: String?
}

var auth: FAuthData!
var queriedlist = [items]();

class loginController:UIViewController{
    
    var this_contr: Bool!
    
    //firebase reference
    static var BASE_URL = "https://koirala.firebaseio.com"
    let stuffItemsRef = Firebase(url: BASE_URL)

    
    @IBOutlet weak var memailField: UITextField!
    @IBOutlet weak var mpassField: UITextField!
    
    @IBOutlet weak var mloginButton: UIButton!
    @IBOutlet weak var msignupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        //constantly checking if the user is authenticated, if the user is, then segue to the main page
        stuffItemsRef.observeAuthEventWithBlock({ authData in
            if authData != nil{
                authdataid = authData.uid;
                auth = authData;
                dispatch_async(dispatch_get_main_queue()) {     //for asynchronous thread
                    self.performSegueWithIdentifier("main", sender: self)
                }
                
            }else{
                print ("not authenticated yet")
            }
        })
    }
    
    
    //for unwinding segue from main viewcontroller when the user clicks logout
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    
    //when user clicks on login, login function in firebasestuff class is called
    @IBAction func mloginAction(sender: AnyObject) {
        firebaseStuff.sharedInstance.doLogin(self.memailField.text!, pass:self.mpassField.text!);
  
    }
    
    
    //when user clicks on sign up, createUser function is called in firebasestuff class
    @IBAction func msignupAction(sender: AnyObject) {
        firebaseStuff.sharedInstance.createUser(memailField.text!, pass:mpassField.text!);
    }
    

    
    
    
    
    
    
    
    
    
}