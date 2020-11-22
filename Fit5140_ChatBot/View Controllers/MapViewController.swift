//
//  MapViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 18/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

// This View Controller is used to display the visited locations added by the user as MKPointAnnotations.

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, DatabaseListener {
    
    //initialising the required attributes
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    var listenerType: ListenerType = .location
    var geofence: CLCircularRegion?
    var locationList: [Location] = []
    var databaseController: DatabaseProtocol?
    var locationController: LocationTableViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
    }
    
    // Function to fetch all the locations stored in the Database [Firebase]
    
    // MARK:- Marking the Annotations
    
    func getAllMarkers() {
        for location in locationList {
            let locationAnnotation = MKPointAnnotation()
            locationAnnotation.title = location.name
            locationAnnotation.subtitle = location.date
            locationAnnotation.coordinate = CLLocationCoordinate2D(latitude: location.lat!, longitude: location.long!)
           mapView.addAnnotation(locationAnnotation)
           focusOn(annotation: locationAnnotation)
        }
    }
    
    //MARK:- Location Services
    
    // Map Location Services : Checks the Authorisation of Location Access by setting up the Location Manager
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Let user use the app
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // show alert instructing user to turn on location
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alert to instruct user that their location is restricted
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
        
    }
    
    
    func checkLocationServices()
    {
        if CLLocationManager.locationServicesEnabled(){
            // setup location manager
            setupLocationManager()
            checkLocationAuthorisation()
            getAllMarkers()
        }
        else
        {
            // display alert letting the user know to turn on location services
             
        }
    }
    
    //MARK:- MAP VIEW
    
    // Map View : Setting the View of Annotations using MKPointAnnotation
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
         databaseController?.addListener(listener: self)
       }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
        databaseController?.removeListener(listener: self)
    }
       
    
    // Map View : Function to set the focus on the Annotation selected
    
    func focusOn(annotation: MKPointAnnotation) {
        mapView.selectAnnotation(annotation, animated: true)
        let zoomRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: regionInMeters,longitudinalMeters: regionInMeters)
        mapView.setRegion(zoomRegion, animated: true)
        
    }
    
    //MARK:- DATABASE LISTENER
    
    func onLocationChange(change: DatabaseChange, locations: [Location]) {
        locationList = locations
    }
    
    func onSymptomChange(change: DatabaseChange, symptoms: [Symptoms]) {
    }
 
}
