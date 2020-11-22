//
//  SymptomDetailTableViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 22/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class SymptomDetailTableViewController: UITableViewController {
    
    var selectedSymptom = Symptoms()
    var selectedSymptomList: [String] = []
    var selectedFeeling: String?
    var selectedDate: String?
    let SECTION_SELECTED_FEELING = 0
    let SECTION_SELECTED_SYMPTOM = 1
    let CELL_SELECTED_FEELING = "selectedFeelingCell"
    let CELL_SELECTED_SYMPTOM = "selectedSymptomCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedSymptomList = selectedSymptom.symptoms
        selectedFeeling = selectedSymptom.feeling
        selectedDate = selectedSymptom.date
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SECTION_SELECTED_FEELING {
            return "How were you feeling?"
        }
        else {
            return "Symptoms that you experienced: "
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_SELECTED_FEELING {
            return 1
        }
        return selectedSymptomList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == SECTION_SELECTED_FEELING {
        let selectedFeelingCell = tableView.dequeueReusableCell(withIdentifier: CELL_SELECTED_FEELING, for: indexPath)
            
            selectedFeelingCell.textLabel?.text = selectedFeeling
            selectedFeelingCell.detailTextLabel?.text = selectedDate

        // Configure the cell...

        return selectedFeelingCell
        }
        
        let selectedSymptomCell = tableView.dequeueReusableCell(withIdentifier: CELL_SELECTED_SYMPTOM, for: indexPath)
        
        selectedSymptomCell.textLabel?.text = selectedSymptomList[indexPath.row]
        
        return selectedSymptomCell
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
