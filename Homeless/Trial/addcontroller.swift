
//  addcontroller.swift
//  Trial
//
//  Created by Preksha Koirala on 4/8/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import UIKit

//class stories that holds the attribute of the stories
class Stories: NSObject {
    var mName: String?
    var mLocation: String?
    var mdescription: String?
    var mImage: UIImage?
    var entityId: String?
    var myName: String?
    var number: NSNumber?
    var comments: NSArray?
    var metadata: KCSMetadata!
    

 override init(){
        
        super.init();
    }
    
    //mapping kinvey attributes with Stories class attributes
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId": KCSEntityKeyId,
            "mName" : "name",
            "mdescription" : "description",
            "mLocation" : "location",
            "mImage" : "mImage",
            "myName" : "myName",
            "number" : "number",
            "comments": "comments",
            "metadata": KCSEntityKeyMetadata,
        
        ]
    }
    
    //mImage property is a collection in kinvey
    override class func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "mImage" : KCSFileStoreCollectionName,
            
        ]
    }
    
    //
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["mImage"]
    }
}


//controller for adding new items
class addcontroller: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var locationOutlet: UITextField!
    @IBOutlet weak var descriptionOutlet: UITextView!
    @IBOutlet var categoryOutlet: UITextField!
    
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        print(KCSUser.activeUser().username)
    }
    
    //when user clicks on upload, stories object is saved along with image reference
    @IBAction func saveImageWithObject(sender: AnyObject) {
        
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([

            KCSStoreKeyCollectionName: "Stories",
            KCSStoreKeyCollectionTemplateClass : Stories.self
            ])
        
        
        let data = UIImageJPEGRepresentation(imageView.image!, 0.9)
        KCSFileStore.uploadData(data, options: nil, completionBlock: {(uploadInfo: KCSFile!, error: NSError!) -> Void in
            print("file id is\(uploadInfo.fileId)");
        
        let story = Stories()
            
        story.metadata = KCSMetadata()
        story.mName = self.nameOutlet.text
        story.mdescription = self.descriptionOutlet.text
        story.mLocation = self.locationOutlet.text
        story.mImage = self.imageView.image!
        story.myName = KCSUser.activeUser().username;
        story.number = 1;
        story.comments = ["no cmnts"];
        story.metadata.setGloballyReadable(true);
            
        someImageStore.saveObject(story, withCompletionBlock: {

            (objectsOrNil:[AnyObject]!, errorOrNil: NSError!) -> Void in
            print("Image Object Saved")
            
            
            
            if errorOrNil != nil {
                //save failed
                NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
            } else {
                //save was successful
                NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
            }
            },
            withProgressBlock: nil
            )
        
            
            }, progressBlock: nil)
    }
   
    //when take photo button is tapped, camera shows up in phone
    @IBAction func TakePhotoButtonTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //when load image button is tapped, gallery shows up
    @IBAction func loadImageButtonTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    //when image is picked up,then the gallery is dismissed and the image is set to the imageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //when user clicks on cancel button while choosing image, dismiss the imagepicker controller
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


