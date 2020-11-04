//
//  SignUpViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 03/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements()
    {
        //Hide the error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    //fields check, if anything is wrong error message is returned
    func validateFields() -> String? {
        
        //empty field check
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            return "Please enter all the fields"
            
            //check for password is valid or not
            
        }
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(email) == false{
            
            return "Please enter a valid email"
            
        }
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(password) == false {
            
            return "Please enter a password with at least 8 characters, containing a special character and a number" 
        }
        
        return nil
    }
    


    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        // Validating the fields
        let error = validateFields()
        
        if error != nil {
            // If error has a value, show error message
            showErrorMessage(error!)
        }
        else {
            
            //create cleaned var of data
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
//                    err?.localizedDescription
                    self.showErrorMessage("Error creating the user")
                }
                else {
//                    Store first and last name
//                    let db = Firestore.firestore()
//                    db.collection("users").addDocument(data: ["firstname" :firstName, "lastname" : lastName, "uid": result!.user.uid ]) { (error) in
//
//                        if error != nil {
//                            self.showErrorMessage("User data unable to saved")
//                        }
//
//                    }
                    
//                    back to home scrren
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
        
        let landingViewController =
                storyboard?.instantiateViewController(identifier:
                    Constants.Storyboard.landingViewController) as? LandingViewController
        
        view.window?.rootViewController = landingViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    func showErrorMessage(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
