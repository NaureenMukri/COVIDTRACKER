//
//  AddLocationTableViewController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 20/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class AddLocationTableViewController: UITableViewController {
    
    //Initialising Variables
    
    let SECTION_LOCATION_DETAILS = 0
    let SECTION_VISIT = 1
    

    @IBOutlet weak var locationNameTextField: UITextField!
    
    @IBOutlet weak var latTextField: UITextField!
    
    @IBOutlet weak var longTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    weak var databaseController: DatabaseProtocol?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        locationNameTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        latTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        longTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        dateTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        timeTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_LOCATION_DETAILS {
            return 5
        }
        
        return 2
    }
    
    //MARK:- Save Location Function

    @IBAction func saveLocation(_ sender: Any) {
              
              if locationNameTextField.text != "" && latTextField.text != "" && longTextField.text != "" && dateTextField.text != "" && timeTextField.text != "" {
              let name = locationNameTextField.text!
              let lat = Double(latTextField.text!)!
              let long = Double(longTextField.text!)!
              let time = timeTextField.text!
              let date = dateTextField.text!
              let _ = databaseController?.addLocation(name: name, date: date, time: time, lat: lat, long: long)
              navigationController?.popViewController(animated: true)
              return
    }
        
        var errorMessage = "Please ensure all the fields are filled"
        
        
        if locationNameTextField.text == "" {
            locationNameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
        }
        if latTextField.text == "" {
            latTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
        }
        if longTextField.text == "" {
                longTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
        }
        if dateTextField.text == "" {
           dateTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorMessage +=  "- Please ensure the date is in DD/MM/YYYY format"
        }
        if timeTextField.text == "" {
            timeTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            errorMessage +=  "- Please ensure the date is in HH:MM (24-Hour Clock) format"
        }
        
        displayMessage(title: "Fields Invalid/Empty", message: errorMessage)
    }
    
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

//MARK:- UITextView Extensions

// To change the appearance of the UITextField based on their respective validations

// When save button is clicked without any validation errors

extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

// When save button is clicked to save location but fields are invalid

extension UITextField {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}


