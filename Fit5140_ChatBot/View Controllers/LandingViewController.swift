//
//  LandingViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 04/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//  Reference : 1. https://www.youtube.com/watch?v=1HN7usMROt8&ab_channel=CodeWithChris

import UIKit
import MapKit

class LandingViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    let locationManager = CLLocationManager()
    

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
