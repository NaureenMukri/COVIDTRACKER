//
//  MapViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 18/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var geofence: CLCircularRegion?
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    var locationAnnotation: [LocationAnnotation] = []
    var databaseController: DatabaseProtocol?
    var locationController: LocationTableViewController?
    
    
    func checkLocationServices()
    {
        if CLLocationManager.locationServicesEnabled(){
            // setup location manager
            setupLocationManager()
            checkLocationAuthorisation()
        }
        else
        {
            // display alert letting the user know to turn on location services
             
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        locationController?.getData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
       }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
       
    func focusOn(annotation: MKAnnotation) {
        mapView.selectAnnotation(annotation, animated: true)
        let zoomRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: regionInMeters,longitudinalMeters: regionInMeters)
        mapView.setRegion(zoomRegion, animated: true)
        
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }

    
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Let user use the app
            mapView.showsUserLocation = true
            centerOnUserLocation()
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
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let alert = UIAlertController(title: "Movement Detected", message: "You have left \(region.identifier)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let alert = UIAlertController(title: "Movement Detected", message: "You have entered \(region.identifier)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? LocationAnnotation else
        {
            return nil
        }
        var annotationView: MKAnnotationView
        let locationAnnotationID = "locations"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: locationAnnotationID) as? MKMarkerAnnotationView {
            view.annotation = annotation
            annotationView = view
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: locationAnnotationID)
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView.largeContentTitle = annotation.title
        }
        return annotationView
        
    }
 
}
