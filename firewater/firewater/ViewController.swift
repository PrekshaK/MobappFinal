//
//  ViewController.swift
//  firewater
//
//  Created by Preksha Koirala on 4/5/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import UIKit
import Firebase

var authdataid: String?
var teststring: String?
var pub: Bool!




class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var pri_pub: UIBarButtonItem!
    @IBOutlet var mcollectionView: UICollectionView!
    var querieddict = [String: [items]]()
    var authData: FAuthData!
    var firestuff: firebaseStuff!
    

    static var BASE_URL = "https://koirala.firebaseio.com"
    let stuffItemsRef = Firebase(url: BASE_URL)
    
    override func viewDidLoad() {
   
        super.viewDidLoad();
        pub = true;
        firebaseStuff().getquery(auth);
        
        //Constantly checking if data is changed. If changed, then reload collectionview
        
        stuffItemsRef.observeEventType(.Value, withBlock: { snapshot in
            firebaseStuff().getquery(auth);
            dispatch_async(dispatch_get_main_queue()) { // for async thread
                print ("reloading")
                self.mcollectionView.reloadData()
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        self.mcollectionView.reloadData()
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.mcollectionView.reloadData()
        super.viewWillAppear(animated);
 
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        mcollectionView.reloadData();
        super.viewDidAppear(true);
    }
    
    
    
    //Toogle private and public button and query accordingly
    @IBAction func private_public(sender: AnyObject) {
        queriedlist = [items]();
        firebaseStuff().getquery(auth);
        self.mcollectionView.reloadData();
        dispatch_async(dispatch_get_main_queue()) {
            self.mcollectionView.reloadData();
        }
        if (pub == true){  //if public is true
            pub = false;    //make public false
            pri_pub.title = "See Private Items";    //set title to see private items
            
        }else{
            pub = true;
            pri_pub.title = "See Public Items";
        }
    }
    

    
    //logout when the user clicks logout
    @IBAction func mlogoutAction(sender: AnyObject) {
        stuffItemsRef.unauth();
        print ("loggedout")
        
        
    }
    
    

    
    //preparing for segue and setting detailpagecontroller variable
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detail" {
            print ("seguing")
            if let indexPaths = self.mcollectionView.indexPathsForSelectedItems(){
                print (indexPaths);
                let indexPath = indexPaths[0]
                
                let object = queriedlist[indexPath.row]
                let nextController = segue.destinationViewController  as! detailController
                nextController.detailObject = object
            }
        }
    }
    
    

    //returns the number of section in collectionview
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //returns the number of cells in collectionview
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queriedlist.count;
    }
    
   
    
    //displays the items in collectionview
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectioncell", forIndexPath: indexPath) as! collectionviewcell
        let oneitem = queriedlist[indexPath.row];
        cell.mImageView.image = oneitem.image1;
        cell.mLabel.text = oneitem.textmsg;
        return cell
        
    }

    
}



