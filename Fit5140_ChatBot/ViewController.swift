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

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField()
        setUpLex()
    }
    func setUpLex() {
        self.interactionKit = AWSLexInteractionKit.init(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
    }
    func setUpTextField() {
        questionTextField.delegate = self
    }
    func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        print("interactionKit error: \(error)")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if  (questionTextField.text?.count)! > 0 {
            sendToLex(text: questionTextField.text!)
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
            self.answerLabel.text = response
        }
    }


}

