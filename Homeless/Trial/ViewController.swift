//
//  ViewController.swift
//  Trial
//
//  Created by Preksha Koirala on 4/8/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import UIKit


var Username: String?


//controller for logging user in
class ViewController: UIViewController {
    
    
    @IBOutlet weak var UserNameValue: UITextField!
    
    @IBOutlet weak var PasswordValue: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        UserNameValue.becomeFirstResponder()
        
        
        //initializing kingey
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "kid_Zy-vmArueZ",
            withAppSecret: "aebce3d6402742b4b2c18ef081ca7580",
            usingOptions: nil
        )
        
        //ping kinvey and check if we are connected to it
        KCSPing.pingKinveyWithBlock { (result: KCSPingResult!) -> Void in
            if result.pingWasSuccessful {
                NSLog("Kinvey Ping Success")
                //self.save()
            } else {
                NSLog("Kinvey Ping Failed")
            }
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //if active user exists then just go to the home page
        
        
        if KCSUser.activeUser() != nil {
            print("performing segue")
            self.performSegueWithIdentifier("homePage", sender: self)
        }
        
    }
    
    //Create a new username with username and password given by the user
    func createNewUser(){

        if KCSUser.activeUser() == nil {
            KCSUser.userWithUsername(
                UserNameValue.text,
                password: PasswordValue.text,
                fieldsAndValues: nil,
                withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                    if errorOrNil == nil {
                        //user is created
                        let message = "Successful"
                        let alert = UIAlertView(
                            title: NSLocalizedString("Successfully created account. Now you can log in", comment: "Good Job"),
                            message: message,
                            delegate: nil,
                            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                        )
                        alert.show()
                    } else {
                        //there was an error with the create
                        let message = errorOrNil.localizedDescription
                        let alert = UIAlertView(
                            title: NSLocalizedString("Problem with creating new account", comment: "Sign up failed"),
                            message: message,
                            delegate: nil,
                            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                        )
                        alert.show()
                        
                        
                    }
                }
            )
            
        }
        else{
            print("already created")
        }
    }

  
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func AddNewUser(sender: AnyObject) {
        //call function createnewuser to create the new user as provided in the fields
        createNewUser()
    }
    
    
    //when user clicks on login
    @IBAction func LoginUser(sender: AnyObject) {
        
        if KCSUser.activeUser() == nil {
        KCSUser.loginWithUsername(
            UserNameValue.text,
            password: PasswordValue.text,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                    self.performSegueWithIdentifier("homePage", sender: self)
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Account does not exist", comment: "Sign account failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                }
            }
        )
        }
        else{ //when user succesfull logs in, segue to the maindisplay controller
            performSegueWithIdentifier("homePage", sender: self)
        }
    }
    
    //when user clicks on logout in maindisplaypage
    //unwind to this controller and log user out
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        KCSUser.activeUser().logout()
    }
    
    
}

