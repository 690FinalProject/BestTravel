//
//  MapViewController.swift
//  BestTravel
//
//  Created by Jangey Lu on 12/9/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    static var spots: [Spot] = []
    
    var annotations = [MKPointAnnotation()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mapView.showsUserLocation = true
        getCurrentLocation()
        addSpotOnMap()
    }
    
    // get user current location in mapView
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
    }
    */
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func addSpotOnMap() {
        let annotationRegion = MKPointAnnotation()
        
        // adding each spot into mapView
        for spot in MapViewController.spots {
            let lat = spot.spotLat
            let lng = spot.spotLng
            let spotName = spot.spotName
            let spotCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
            
            // adding each spot into MAP
            let annotation = MKPointAnnotation()
            annotation.coordinate = spotCoordinate
            annotation.title = spotName
            annotations.append(annotation)
            
            // update last annotation coordinate
            annotationRegion.coordinate = spotCoordinate
        }
        mapView.addAnnotations(annotations)
        
        // update Region
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let newLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(annotationRegion.coordinate.latitude, annotationRegion.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: newLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func refreshLocaton(_ sender: Any) {
        // remove all map annotations & clear annotaions list
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        
        // add new annotations from list
        addSpotOnMap()
    }
    
}
