//
//  TabItem.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 5/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case profile = "Profile"
    case chat = "Chat"
    case home = "Home"
    case map = "map"
    case symptoms = "symptoms"
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .chat:
            return ViewController()
        case .profile:
            return ProfileViewController()
        case .map:
            return MapViewController()
        case .symptoms:
            return SymptomViewController()
        }
    }
    // these can be your icons
    var icon: UIImage {
        switch self {
        case .profile:
            return UIImage(named: "ic_phone")!
        case .chat:
            return UIImage(named: "ic_camera")!
        case .home:
            return UIImage(named: "ic_contacts")!
        case .map:
            return UIImage(named: "ic_message")!
        case .symptoms:
            return UIImage(named: "ic_man")!
        }
    }
    
var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
