//
//  drawPoliline.swift
//  AppleMap
//
//  Created by MobioApp on 5/22/17.
//  Copyright © 2017 MobioApp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class drawPoliline: NSObject, MKAnnotation {

    var title : String?
    var subtitle : String?
    var latitude : Double
    var longitude : Double
    
    var cordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    /*
    let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
    let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
    
    let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
    let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
    
    let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
    let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
    
    let sourceAnnotation = MKPointAnnotation()
    sourceAnnotation.title = "Times Square"
    
    if let location = sourcePlacemark.location {
        sourceAnnotation.coordinate = location.coordinate
    }
    
    let destinationAnnotation = MKPointAnnotation()
    destinationAnnotation.title = "Empire State Building"
    
    if let location = destinationPlacemark.location {
        destinationAnnotation.coordinate = location.coordinate
    }
    
    mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
    
    let directionRequest = MKDirectionsRequest()
    directionRequest.source = sourceMapItem
    directionRequest.destination = destinationMapItem
    directionRequest.transportType = .automobile
    
    let directions = MKDirections(request: directionRequest)
    
    directions.calculate {
    (response, error) -> Void in
    
    guard let response = response else {
    if let error = error {
    print("Error: \(error)")
    }
    
    return
    }
    
    let route = response.routes[0]
    self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
    
    let rect = route.polyline.boundingMapRect
    self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
    }

     func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     let renderer = MKPolylineRenderer(overlay: overlay)
     renderer.strokeColor = UIColor.red
     renderer.lineWidth = 4.0
     
     return renderer
     }

 */
    
}
