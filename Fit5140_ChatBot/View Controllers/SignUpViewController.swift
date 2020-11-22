//
//  SignUpViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 03/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//  Reference : 1. https://www.youtube.com/watch?v=1HN7usMROt8&ab_channel=CodeWithChris

// This is the Sign-Up Screen that provides the user with the option to provide in their authentication details so as to Register with the COVID Tracker Application

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
    
    //MARK:- Validation and Exception Handling
    
    //Validating the fields for the user so that errors can be prevented while registering
    
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
            
            // Storing the fields trimming the white spaces and new lines
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Creating the user with the email and password provided through Firebase Authentication

            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    self.showErrorMessage("Error creating the user")
                }
                else {
//              Storing first and last name of the user through Firestore
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname" :firstName, "lastname" : lastName, "uid": result!.user.uid ]) { (error) in

                        if error != nil {
                            self.showErrorMessage("User data unable to saved")
                        }

                    }
                    // After successfully signing up as a user - the user is taken to the Home Screen of the COVID Tracker app
                    self.transitionToHome()
                }
            }
        }
    }
    
    // Function to transition the user to the Home Page of the application after successfull applications
    
    func transitionToHome() {
        
        let homeViewController =
                storyboard?.instantiateViewController(identifier:
                    Constants.Storyboard.landingViewController) as? TabMenuViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    // Function to display Errors
    
    func showErrorMessage(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
