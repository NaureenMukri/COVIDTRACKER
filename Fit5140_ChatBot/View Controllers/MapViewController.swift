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
    var locationAnnotation: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    //MARK : - GET IMAGE REQUESTS
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard let annotation = annotation as? Location else {
//            return nil
//        }
//        let exhibitAnnotationID = "exhibition"
//        var annotationView: MKAnnotationView
//        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: exhibitAnnotationID) as? MKMarkerAnnotationView {
//            view.annotation = annotation
//            annotationView = view
//        } else {
//            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: exhibitAnnotationID)
//            annotationView.canShowCallout = true
//            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            annotationView.largeContentTitle = annotation.name
//        }
//        return annotationView
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
