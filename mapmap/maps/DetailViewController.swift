//
//  DetailViewController.swift
//  maps
//
//  Created by Preksha Koirala on 3/1/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.import



import UIKit

class DetailViewController: UIViewController{
    
   
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subtitleView: UILabel!
    @IBOutlet weak var placeIdView: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    var detaillocation = mapLocation()
    var image: String?
    
    override func viewDidLoad() {
        
        titleView.text = detaillocation.title
        subtitleView.text = String(detaillocation.coordinate.latitude) + " " + String(detaillocation.coordinate.longitude)
        placeIdView.text = detaillocation.placeId
        
        if let url = NSURL(string: detaillocation.image!) {
            if let data = NSData(contentsOfURL: url) {
                mImageView.image = UIImage(data: data)
            }
        }
        super.viewDidLoad()
        
    }
    

    
    
}