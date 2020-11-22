//
//  ViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 16/10/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import AWSLex

class ViewController: UIViewController, AWSLexInteractionDelegate, UITextFieldDelegate {
    
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
    func setUpLex() {
        self.interactionKit = AWSLexInteractionKit.init(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
    }
    func setUpTextField() {
        questionTextField.delegate = self
        continueTextField.delegate = self
        moreTextField.delegate = self
    }
    func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        print("interactionKit error: \(error)")
    }
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
    func sendToLex(text : String){
        self.interactionKit?.text(inTextOut: text, sessionAttributes: nil)
    }
    //handle response
    func interactionKit(_ interactionKit: AWSLexInteractionKit, switchModeInput: AWSLexSwitchModeInput, completionSource: AWSTaskCompletionSource<AWSLexSwitchModeResponse>?) {
        guard let response = switchModeInput.outputText else {
            let response = "No reply from bot"
            print("Response: \(response)")
            return
        }
    //show response on screen
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

