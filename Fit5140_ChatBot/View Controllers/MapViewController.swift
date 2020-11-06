//
//  MapViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 5/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func focusOn(annotation: MKAnnotation) {
        MapView.selectAnnotation(annotation, animated: true)
        
        let zoomRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        MapView.setRegion(MapView.regionThatFits(zoomRegion), animated: true)
    }
    
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
