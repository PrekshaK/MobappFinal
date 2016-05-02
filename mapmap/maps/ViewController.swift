import UIKit
import MapKit
import CoreLocation




var searchKey = ""
let GOOGLE_API_KEY = "AIzaSyB9Yzf1rT5v01NZBiv4mj4HPzRr4AhOC0w"

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate{

    var image: String?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var keyword: UITextField!
    
    //set locvalue as location changes
    var locValue:CLLocation!{
        didSet{
            let coord = self.locValue.coordinate
            print (coord.latitude)
            print(coord.longitude)
        }
    }
    
    
    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()    //ask for location access
        locationManager.startUpdatingLocation()
        
        print ("here")
        
        self.keyword.becomeFirstResponder()
        super.viewDidLoad()
    }
    
    
 
    //declaring view for annotaion
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myspot")
        annotationView.animatesDrop = true
        annotationView.canShowCallout = true
        annotationView.pinTintColor = UIColor.blueColor()
        
        let button = UIButton(type: .DetailDisclosure)
        annotationView.rightCalloutAccessoryView = button
        return annotationView
    }

    //segue to detail page when clicked on annotation
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! mapLocation
        print ("we are here")
        self.performSegueWithIdentifier("DetailPageSegue", sender: location)
        
    }
    
    
    //when segueing, set the detaillocation of detailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "DetailPageSegue"){
            let detailView:DetailViewController = segue.destinationViewController as! DetailViewController
            detailView.detaillocation = (sender as? mapLocation)!
        }
    }
    
    
    //when search key is entered in textfield, retrieve data from api call and show annotations on the mapview
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        //resigning as first responder
        keyword.resignFirstResponder()
        
        
        //remove previous annotations
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )

        searchKey = keyword.text!
        var baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(locValue.coordinate.latitude),\(locValue.coordinate.longitude)&radius=500&type=restaurant&name=\(searchKey)&key=\(GOOGLE_API_KEY)"
        
        
       //declaring center and vicinity of the map
        let center = CLLocationCoordinate2DMake(locValue.coordinate.latitude, locValue.coordinate.longitude)
        let region = MKCoordinateRegion(center:center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL)!)
        let task = session.dataTaskWithRequest(request){
            (data, response, error)-> Void in
            if error != nil {
                print (error!.localizedDescription)
                return
            }
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                //Go through the jsonobject as results we get
                if let items = json["results"] as? [[String: AnyObject]]{
                    for items in items{

                        if let name = items["name"] as? String, let vicinity = items["vicinity"] as? String{
                            let coords: [Double] = self.getCoords(items["geometry"] as! Dictionary)
                            //if there are photos present in items
                            if let photo = items["photos"]{
                                self.image = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + ((photo.valueForKey("photo_reference"))![0] as! String) + "&key=" + GOOGLE_API_KEY
                            }
                            let annotation = mapLocation(title: name, coordinate: CLLocationCoordinate2D(latitude: coords[0], longitude:coords[1]), placeId: vicinity, subtitle: "delicious", image: self.image!)
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                    //updating UI on the main thread
                    dispatch_async(dispatch_get_main_queue()){
                        self.mapView.setRegion(region, animated: true)
                    }
                }
            }catch{
                print("error serializing json")
            }
        }
        task.resume()
        return true;
    }
    
    

    //After updating location, set the region of map
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("yes")
        locValue = manager.location!
        let center = CLLocationCoordinate2DMake(locValue.coordinate.latitude, locValue.coordinate.longitude)
        let region = MKCoordinateRegion(center:center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        //pinning annotations when view loads
        self.mapView.setRegion(region, animated: true)
        
        print("locations = \(locValue.coordinate.latitude) \(locValue.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
    }
    
    
    //getting coords
    func getCoords(data: [String:AnyObject]) -> [Double]{
        let c = data["location"] as![String: AnyObject]
        print (c)
        return [c["lat"] as! Double, c["lng"] as! Double]
        
    }
    
    
    
    
}








