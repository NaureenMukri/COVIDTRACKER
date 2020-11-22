//
//  AddSymptomsTableViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 22/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//  References : 1. https://stackoverflow.com/questions/37118812/how-to-make-checklist-in-uitableview-swift
// 2. https://stackoverflow.com/questions/36513969/check-uncheck-the-check-box-by-tapping-the-cell-in-table-view-and-how-to-know
// 3. https://stackoverflow.com/questions/39513258/get-current-date-in-swift-3/39514533


import UIKit

class AddSymptomsTableViewController: UITableViewController {
    
    // Initialising the Variables
    
    let CELL_FEELING = "feelingCell"
    let CELL_SYMPTOM = "symptomCell"
    var feelings = ["Happy", "Not Good"]
    var symptoms = ["Fatigue or Tiredness", "Fever", "Cough", "Pain in Chest with deep breaths", "Shortness Of Breath", "Loss of Smell", "Loss of Taste", "Headache", "Muscle Aches"]
    let SECTION_FEELING = 0
    let SECTION_SYMPTOMS = 1
    var selectedSymptoms: [String] = []
    var selectedFeeling: String = ""
    weak var databaseController: DatabaseProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.setEditing(true, animated: true)
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SECTION_FEELING {
            return "How are you Feeling Today?"
        }
        return "What Symptoms do you have?"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_SYMPTOMS {
            self.tableView.allowsMultipleSelectionDuringEditing = true
            return symptoms.count
        }
        
        self.tableView.allowsMultipleSelection = false
        return feelings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == SECTION_FEELING {
        let feelingsCell = tableView.dequeueReusableCell(withIdentifier: CELL_FEELING, for: indexPath) as! CheckableTableViewCell
            
             // Configure the cell...
            
            feelingsCell.textLabel?.text = feelings[indexPath.row]

        return feelingsCell
        }
        
        let symptomCell = tableView.dequeueReusableCell(withIdentifier: CELL_SYMPTOM, for: indexPath) as! CheckableTableViewCell
        
        symptomCell.textLabel?.text = symptoms[indexPath.row]

        return symptomCell
    }
    
    // Adding selected Symptoms to the Symptoms List
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_FEELING {
            selectedFeeling = feelings[indexPath.row]
        }
        else {
            let selectedSymptom = symptoms[indexPath.row]
            selectedSymptoms.append(selectedSymptom)
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell!.isSelected
        {
            cell?.editingAccessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else {
             cell?.editingAccessoryType = UITableViewCell.AccessoryType.none
        }
        
        
        
    }

    // Function to save selected Feeling and Symptoms

    @IBAction func saveSymptoms(_ sender: Any) {
        
        let feeling = selectedFeeling
        let symptoms = selectedSymptoms
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        let symptomDate = formatter.string(from: date)
        let _ = databaseController?.addSymptoms(date: symptomDate, feeling: feeling, symptoms: symptoms)
        navigationController?.popViewController(animated: true)
        return
        
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
