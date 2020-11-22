//
//  Location.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 17/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class Location: NSObject, Decodable, Encodable {
   
    var id: String?
    var name: String?
    var date: String?
    var time: String?
    var lat: Double?
    var long: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case time
        case lat
        case long
    }

}

