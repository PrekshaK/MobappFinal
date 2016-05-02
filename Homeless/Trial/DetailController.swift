
//  DetailController.swift
//  Trial
//
//  Created by Preksha Koirala on 4/8/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//


import UIKit


class DetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var detailItem : Stories!

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var hName: UITextView!
    @IBOutlet weak var mlocation: UITextView!
    @IBOutlet weak var mCharacteristics: UILabel!
    @IBOutlet weak var muploadedBy: UILabel!
    @IBOutlet weak var mStoryvalue: UILabel!
    @IBOutlet weak var mcommentView: UITextView!
    @IBOutlet weak var mtableView: UITableView!
    @IBOutlet weak var editingDone: UIButton!
   
    
    
    override func viewDidLoad() {
        
        let name1 = KCSUser.activeUser().username;
        let name2 = detailItem.myName! as! String;
        if name1 != name2{
            mlocation.editable = false;
            hName.editable = false;
            editingDone.isAccessibilityElement = false;
        }
        hName.text = detailItem.mName;
        mlocation.text = detailItem.mLocation;
        mStoryvalue.text  = detailItem.mdescription;
        mImageView.image = detailItem.mImage;
        
    }
    
    //when click on share button, it's shared to the sharable applications that are available in the phone
    @IBAction func shareAction(sender: AnyObject) {
        let activityViewController = UIActivityViewController(
            activityItems: [mStoryvalue.text as! NSString],
            applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }

    //Call owner. Works only in phone not in simulator
    @IBAction func mCallAction(sender: AnyObject) {
        let phone = "tel://" + String(detailItem.myName);
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
    }
    
//    //
//    @IBAction func commentAction(sender: AnyObject) {
//        self.mcommentView.becomeFirstResponder();
//    }
    
    //Add comments to the story when click on done
    @IBAction func doneAction(sender: AnyObject) {
        
        let newComment = mcommentView.text;
        var commentsarray = detailItem.comments as! [String]
        commentsarray.append(newComment)
        detailItem.comments = commentsarray as! NSArray
        self.mtableView.reloadData();
        
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Stories",
            KCSStoreKeyCollectionTemplateClass : Stories.self
            ])
        
        someImageStore.saveObject(detailItem, withCompletionBlock: {
            (objectsOrNil:[AnyObject]!, errorOrNil: NSError!) -> Void in
            print("Image Object Saved")
            if errorOrNil != nil {
                //save failed
                NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
            }else {
                //save was successful
                NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
            }
            },
            withProgressBlock: nil
        )
    }
    

    //when Editing done button is clicked, the edited fields are saved to kinvey
    @IBAction func editaction(sender: AnyObject) {
        detailItem.mName = hName.text;
        detailItem.mLocation = mlocation.text;
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Stories",
            KCSStoreKeyCollectionTemplateClass : Stories.self
            ])
        someImageStore.saveObject(detailItem, withCompletionBlock: {
            
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
    }
    
    

    // No of sections in table view for comment table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    //no of rows in section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let comments = detailItem.comments{
            return comments.count
        }else{
            return 0;
        }
    }

    
    // contents on tableview row are set
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let commentcell = UITableViewCell(style: .Value1, reuseIdentifier: "commentcell")
        commentcell.textLabel?.text = detailItem.comments![indexPath.row] as! String
        return commentcell
    }
    
    
    
    
    
    
    

}