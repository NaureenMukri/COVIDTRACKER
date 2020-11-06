//
//  LandingViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 04/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements()
    {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
