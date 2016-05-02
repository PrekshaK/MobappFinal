//  MainDisplayPage.swift
//  Trial
//
//  Created by Preksha Koirala on 4/8/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//


import UIKit

class MainDisplayController:UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    var valueFromQuery: [Stories] = []
    var clotharray: [Stories] = [Stories]();

    //when user clicks on addStory button, we segue to addcontroller view
    @IBAction func addStoryAction(sender: AnyObject) {
        self.performSegueWithIdentifier("addDress", sender: self)
    }

    @IBOutlet weak var mCollectionView:UICollectionView!;
    

    override func viewDidLoad() {
        
        let collection = KCSCollection(fromString: "Stories", ofClass: Stories.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        store.queryWithQuery(
            KCSQuery(onField: "number", usingConditional: KCSQueryConditional.KCSGreaterThan, forValue:0),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil == nil {
                    self.valueFromQuery = objectsOrNil as! NSObject as! [Stories]
                    print(self.valueFromQuery)
                    self.mCollectionView.reloadData()
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
            },
            withProgressBlock: nil
        )

        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let collection = KCSCollection(fromString: "Stories", ofClass: Stories.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        store.queryWithQuery(
            KCSQuery(onField: "number", usingConditional: KCSQueryConditional.KCSGreaterThan, forValue:0),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil == nil {
                    self.valueFromQuery = objectsOrNil as! NSObject as! [Stories]
                    print(self.valueFromQuery)
                    self.mCollectionView.reloadData()
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
            },
            withProgressBlock: nil
        )

        print (UIImage(named: "Image"));
        super.viewWillAppear(true)
    }
    
    
   
    //passing object to detail page while doing segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "paymentShow" {
            if let indexPaths = self.mCollectionView.indexPathsForSelectedItems(){
                print (indexPaths);
                let indexPath = indexPaths[0]
        
                let object = valueFromQuery[indexPath.row]
                let nextController = segue.destinationViewController  as! DetailController
                nextController.detailItem = object
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //no of sections in collectionview
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    //no of items in one section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.valueFromQuery.count;
    }
    
    
    // setting up the contents of collectionviewcell
      func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! mCollectionViewCell;
        var cloth = valueFromQuery[indexPath.row];
        cell.mImageView.image = cloth.mImage
        cell.mNameView.text = String(cloth.mName!)
        cell.mLocationView.text = cloth.mLocation
        cell.mDescriptionView.text = cloth.mdescription
        return cell;
      }
    
    

    
    //Query All stories be it private or public from kinvey
    @IBAction func allStories(sender: AnyObject) {
        
        let collection = KCSCollection(fromString: "Stories", ofClass: Stories.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        store.queryWithQuery(
            KCSQuery(onField: "number", usingConditional: KCSQueryConditional.KCSGreaterThan, forValue:0),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil == nil {
                    self.valueFromQuery = objectsOrNil as! NSObject as! [Stories]
                    self.mCollectionView.reloadData()
                    
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
            },
            withProgressBlock: nil
        )
    }
    
    
    //Query only private stories from kinvey
    @IBAction func myStories(sender: AnyObject) {
        let collection = KCSCollection(fromString: "Stories", ofClass: Stories.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        store.queryWithQuery(
            KCSQuery(onField: "myName", withExactMatchForValue: KCSUser.activeUser().username),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil == nil {
                    self.valueFromQuery = objectsOrNil as! NSObject as! [Stories]
                    self.mCollectionView.reloadData()
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
            },
            withProgressBlock: nil
        )
    }
}

    
    
    
    
    
    
    
    
    
    
    
    

    


