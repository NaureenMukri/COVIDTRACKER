//
//  DatabaseController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 18/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import Foundation

 enum DatabaseChange {
    case add
    case remove
    case update
}

enum ListenerType {
    case location
    case symptoms
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onLocationChange(change: DatabaseChange, locations: [Location])
}

protocol DatabaseProtocol: AnyObject {
    
    var defaultLocation: Location {get}
    func cleanup()
    func addLocation(id: String, name: String, date: String, time: String, lat: Double, long: Double) -> Location
    func deleteLocation(location: Location)
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
