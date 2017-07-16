//
//  ViewController.swift
//  AppleMap
//
//  Created by MobioApp on 5/21/17.
//  Copyright © 2017 MobioApp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager() // initialize u'r lcationManager
    var latValue : Double = 0.0
    var longValue : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.standard // satettite , standard , hybrid
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() { // get my current locations lat, lng
            
            let lat = locationManager.location?.coordinate.latitude
            let long = locationManager.location?.coordinate.longitude
            
            if let lattitude = lat  {
                if let longitude = long {
                    latValue = lattitude
                    longValue = longitude
                } else {
                    
                }
            } else {
                
                print("problem to find lat and lng")
            }
            
            locationManager.startUpdatingLocation()
        }
        else {
            print("Location Service not Enabled. Plz enable u'r location services")
        }
        
        locationManager.requestWhenInUseAuthorization() // Call the authorizationStatus() class method to get the current authorization status for your app.If the authorization status is restricted or denied, your app is not permitted to use location services and you should abort your attempt to use them.
        
        reverseGEOCODE(latitude: latValue, longitude: longValue)
        
        let latitude:CLLocationDegrees = latValue
        let longitude:CLLocationDegrees = longValue
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        
        print("lattitude and longitude = \(latitude) and  \(longitude)")
        //  calculate distance Empire state Building -> Times Square
        /*
         let userLocation:CLLocation = CLLocation(latitude: 40.759011, longitude: -73.984472)
         let priceLocation:CLLocation = CLLocation(latitude: 40.748441, longitude: -73.985564)
         let meters:CLLocationDistance = userLocation.distance(from: priceLocation)
         */
        latLabel.text = "latitude : \(String(latValue))"
        longLabel.text = "longitude : \(String(longValue))"
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        //or use insted.............
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(latitude, longitude), MKCoordinateSpanMake(latDelta, lonDelta)), animated: true)
        
        var points =  [CLLocationCoordinate2D]()
        
        var latLongArray : NSArray?
        if let path = Bundle.main.path(forResource: "stations", ofType: "plist"){
            latLongArray = NSArray(contentsOfFile : path)
        }
        
        if let items = latLongArray {
            for item in items {
                
                let latitude    = (item as AnyObject).value(forKey: "lat")
                let longitude   = (item as AnyObject).value(forKey: "long")
                let titleString = (item as AnyObject).value(forKey: "title")
                points.append(CLLocationCoordinate2DMake(latitude as! CLLocationDegrees, longitude as! CLLocationDegrees))
                drawMarker(title: titleString as! String, lat: latitude as! CLLocationDegrees , long: longitude as! CLLocationDegrees)
                
            }
        }
        let polyline = MKPolyline(coordinates: &points, count: points.count)
        mapView.add(polyline)
        
    }
    
    
    func drawMarker(title: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        
        let cordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = cordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error.localizedDescription")
    }
    
    //
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        latLabel.text = "latitude : \(String(lat))"
        longLabel.text = "longitude : \(String(long))"
    }
    
    // use reverse GEOCode to find address from coordinate
    func reverseGEOCODE(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            guard let addressDict = placemarks?[0].addressDictionary else {
                return
            }
            
            // Print each key-value pair in a new row
            addressDict.forEach { print($0) }
            
            // Print fully formatted address
            if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                print("formatted address = \(formattedAddress.joined(separator: ", "))")
            }
            
            if let locationName = addressDict["Name"] as? String {
                print("location name = \(locationName)")
            }
            if let street = addressDict["Thoroughfare"] as? String {
                print("street = \(street)")
            }
            if let city = addressDict["City"] as? String {
                print("city = \(city)")
            }
            if let zip = addressDict["ZIP"] as? String {
                print("zip = \(zip)")
            }
            if let country = addressDict["Country"] as? String {
                print("country = \(country)")
            }
        })
    }
}

