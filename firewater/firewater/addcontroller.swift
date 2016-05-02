//
//  addcontroller.swift
//  firewater
//
//  Created by Preksha Koirala on 4/10/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var is_private: Bool!

class addcontroller: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemlist = [items]();
    var mdatePicker = UIDatePicker()
    
    @IBOutlet weak var private_button: UIButton!
    @IBOutlet weak var mtextfield: UITextField!
    @IBOutlet weak var mdateField: UITextField!
    @IBOutlet weak var mpickdateButton: UIButton!
    @IBOutlet weak var mImageView: UIImageView!
    
    var firestuff: firebaseStuff!
    var currentitem: Firebase!

    //initializing imagepickercontroller
    let imagePicker = UIImagePickerController();
    
    //base url for firebase
    static var BASE_URL = "https://koirala.firebaseio.com"
    let ItemsRef = Firebase(url: BASE_URL)
    
    
    
    
    override func viewDidLoad() {
        is_private = false;         //setting data public as default
        imagePicker.delegate = self;
        super.viewDidLoad()
        initializeDatePicker()       //initializing datepicker
    }

    //when private button is clicked
    @IBAction func is_Private(sender: AnyObject) {
        is_private = true;
        private_button.backgroundColor = UIColor.yellowColor();
        
        
    }

    //choosing images from gallery using imagepicker
    @IBAction func mchoose(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
 
    }
    
    //when the upload button is clicked, get text, image and date typed and chosen
    @IBAction func mupload(sender: AnyObject) {

        private_button.backgroundColor = UIColor.whiteColor();
        var data: NSData = NSData()
        if let image = mImageView.image{
            data = UIImageJPEGRepresentation(image,0.1)!
        }
        //decode image to string
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let oneitem: NSDictionary = ["text1": self.mtextfield.text!, "image1": base64String, "date":self.mdateField.text! ];
        let str = self.mtextfield.text!
        
        //call upload function from firebase
        firebaseStuff().upload(oneitem, str: str);
        
    }
    
    
    //picking image from gallery and setting imageview's image to the picked image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            mImageView.contentMode = .ScaleAspectFit
            mImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //dismiss imagepicker when the image is picked
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    
    
}


//Extension for DatePicker
extension addcontroller{
    
    func initializeDatePicker() {
        
        mdatePicker.datePickerMode = UIDatePickerMode.Date;
        
        // this will make the picker appear, when the date
        // needs to be set
        
        mdateField.inputView = mdatePicker
        mdateField.textAlignment = .Center
        
        // set the tool bar
        let toolBar = UIToolbar(frame: CGRect.init(x:0, y:0, width:320, height:44))
        toolBar.tintColor = UIColor.grayColor()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "datePickerChanged")
        
        let canelBtn = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "datePickerCancelled")
        
        let spacerBtn = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([canelBtn,spacerBtn,doneBtn], animated: true)
        mdateField.inputAccessoryView = toolBar
        
    }
    

    //pop up datepicker when the button is clicked
    @IBAction func pickDateAction(sender: AnyObject) {
        mdateField.becomeFirstResponder()
    }

    
    // when cancelled button is pressed from datepicker, resign first responder
    func datePickerCancelled() {
        mdateField.resignFirstResponder()
    }
    

    //when date is picked from datepicker, the date is formatted and datefield is resigned as first responder
    func datePickerChanged() {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let strDate = dateFormatter.stringFromDate(mdatePicker.date)
        mdateField.text = strDate
        mdateField.resignFirstResponder()
    }

    
    
    
}




