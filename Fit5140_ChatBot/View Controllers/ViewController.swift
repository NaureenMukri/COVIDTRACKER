//
//  ViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 16/10/20.
//  Copyright © 2020 Monash University. All rights reserved.
//
// Reference : How to Build an AWS Lex ChatBot https://medium.com/libertyit/how-to-build-an-aws-lex-chatbot-for-an-ios-app-9fd7693353b

import UIKit
import AWSLex

class ViewController: UIViewController, AWSLexInteractionDelegate, UITextFieldDelegate {
    
    //Initialising Variables

    var interactionKit: AWSLexInteractionKit?
    var count = 0
    var count1 = 0
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var continueTextField: UITextField!
    @IBOutlet weak var moreTextField: UITextField!
    @IBOutlet weak var answerLabel2: UILabel!
    @IBOutlet weak var answerLabel3: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerLabel.alpha = 0
        self.continueTextField.alpha = 0
        self.moreTextField.alpha = 0
        self.answerLabel2.alpha = 0
        self.answerLabel3.alpha = 0

        setUpTextField()
        setUpLex()
        
    }

    
    // MARK:- Setting Up the ChatBot [Chatty] by using Amazon Lex
    
    func setUpLex() {
        self.interactionKit = AWSLexInteractionKit.init(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
    }
    
    func setUpTextField() {
        questionTextField.delegate = self
        continueTextField.delegate = self
        moreTextField.delegate = self
    }
    
    // Setting the interaction kit for Lex [Chatty]
    
    func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        print("interactionKit error: \(error)")
    }

    
    // Setting up Requests and Response for Lex [Chatty]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if  (questionTextField.text?.count)! > 0 && count1 == 0 {
            sendToLex(text: questionTextField.text!)
            count1 = 1
        }
        else if (continueTextField.text?.count)! > 0 && count1 == 1 {
            sendToLex(text: continueTextField.text!)
            count1 = 2
        }

        else if (moreTextField.text?.count)! > 0 && count == 2 {
            sendToLex(text: moreTextField.text!)
        }
        return true
    }
    
    // Sending the request to Lex [Chatty]
    
    func sendToLex(text : String){
        self.interactionKit?.text(inTextOut: text, sessionAttributes: nil)
    }
    
    
    // Handling the Response from Lex
    
    func interactionKit(_ interactionKit: AWSLexInteractionKit, switchModeInput: AWSLexSwitchModeInput, completionSource: AWSTaskCompletionSource<AWSLexSwitchModeResponse>?) {
        guard let response = switchModeInput.outputText else {
            let response = "No reply from bot"
            print("Response: \(response)")
            return
        }
        
        
        //show response on screen from Lex
        
        DispatchQueue.main.async{
            self.answerLabel.alpha = 1
            self.continueTextField.alpha = 1
            if (self.count == 0 && self.questionTextField.text?.count != 0) {
                self.answerLabel.text = response
                self.count = 1
            }
            else if(self.continueTextField.text?.count) != 0 && self.count == 1 {
                self.answerLabel2.alpha = 1
                self.answerLabel2.text = response
                if (response != "That\'s alright! See you again soon. Take care, friend!")
                {
                    self.moreTextField.alpha = 1
                    self.count = 2
                }
            }
            else if(self.moreTextField.text?.count != 0 && self.count == 2) {
                self.answerLabel3.alpha = 1
                self.answerLabel3.text = response
                }
        }
    }


}

