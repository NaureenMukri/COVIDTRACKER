//
//  HomeViewController.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 03/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//  Reference: 1. https://www.youtube.com/watch?v=1HN7usMROt8&ab_channel=CodeWithChris

// We are using the data from the Department of Human Health and Services of Victoria to keep the user updated with the current situation of the of the Coronavirus Pandemic. Reference : - https://www.dhhs.vic.gov.au/latest-news-and-data-coronavirus-covid-19

// This is the home page of the application

import UIKit
 
class HomeViewController: UIViewController {

    @IBOutlet weak var dhhsWebsiteLink: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dhhsWebsiteLink.isEditable = false
        dhhsWebsiteLink.dataDetectorTypes = .link


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: U IStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
