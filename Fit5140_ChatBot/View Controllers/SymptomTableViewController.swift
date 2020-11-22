//
//  SymptomTableViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 22/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class SymptomTableViewController: UITableViewController, DatabaseListener {
    
    let CELL_SYMPTOM = "historyCell"
    
    var listenerType: ListenerType = .symptoms
    var allSymptoms: [Symptoms] = []
    var databaseController: DatabaseProtocol?
    var firebaseController: FirebaseController?
    var selectedSymptom = Symptoms()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK:- Database Listeners
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    func onLocationChange(change: DatabaseChange, locations: [Location]) {
        
    }
    
    func onSymptomChange(change: DatabaseChange, symptoms: [Symptoms]) {
        allSymptoms = symptoms
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allSymptoms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let symptomCell = tableView.dequeueReusableCell(withIdentifier: CELL_SYMPTOM, for: indexPath)
        
        let symptom = allSymptoms[indexPath.row]
        
        symptomCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        symptomCell.textLabel?.text = symptom.feeling
        symptomCell.detailTextLabel?.text = symptom.date

        // Configure the cell...

        return symptomCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSymptom = allSymptoms[indexPath.row]
        performSegue(withIdentifier: "symptomDetailSegue", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Record History: "
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        headerView.backgroundColor = UIColor.yellow
//        let label = UILabel()
//        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//        label.text = "Notification Times"
//        label.textColor = UIColor.secondaryLabel
//
//        headerView.addSubview(label)
//
//        return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "symptomDetailSegue" {
            let destination = segue.destination as! SymptomDetailTableViewController
            destination.selectedSymptom = selectedSymptom
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
