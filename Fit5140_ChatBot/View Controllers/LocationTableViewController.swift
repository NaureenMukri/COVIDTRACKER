//
//  LocationTableViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 16/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import MapKit

class LocationTableViewController: UITableViewController, DatabaseListener {


    let CELL_LOCATION = "locationCell"
    
    weak var mapViewController: MapViewController!
    var listenerType: ListenerType = .location
    var allLocations: [Location] = []
    var databaseController: DatabaseProtocol?
    var firebaseController: FirebaseController?
    
    
    func getData() -> [LocationAnnotation] {
        let storedLocations = allLocations
            var annotations = [LocationAnnotation]()
            for storedLocation in storedLocations {
                let newAnnotation = LocationAnnotation(id: storedLocation.id!, title: storedLocation.name!, subtitle: storedLocation.date!, lat: storedLocation.lat!, long: storedLocation.long!)
                annotations.append(newAnnotation)
            }
        return annotations
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK:- Database Listener
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    func onLocationChange(change: DatabaseChange, locations: [Location]) {
        allLocations = locations
    }
    
    func onSymptomChange(change: DatabaseChange, symptoms: [Symptoms]) {
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Places you have been to:"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allLocations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: CELL_LOCATION, for: indexPath)
        let location = allLocations[indexPath.row]
        
        locationCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        locationCell.textLabel?.text = location.name
        locationCell.detailTextLabel?.text = location.time
    

        // Configure the cell...

        return locationCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = self.allLocations[indexPath.row]
        let locationAnnotation = MKPointAnnotation()
        locationAnnotation.title = selectedLocation.name
        locationAnnotation.subtitle = selectedLocation.date
        locationAnnotation.coordinate = CLLocationCoordinate2D(latitude: selectedLocation.lat!, longitude: selectedLocation.long!)
        mapViewController?.mapView.addAnnotation(locationAnnotation)
        mapViewController?.focusOn(annotation: locationAnnotation)
    }

    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    }
//

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allLocations.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
