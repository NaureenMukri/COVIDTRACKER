//
//  Symptoms.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 22/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import Foundation


class Symptoms: NSObject, Encodable, Decodable {
    
    var id: String?
    var date: String?
    var feeling: String?
    var symptoms: [String] = []
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case feeling
        case symptoms
    }
}
