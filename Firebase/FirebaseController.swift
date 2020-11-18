//
//  FirebaseController.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 18/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseController: NSObject, DatabaseProtocol {

    var defaultLocation: Location
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var locationRef: CollectionReference?
    var locationList: [Location]
    
    override init() {
        // To use Firebase in our application we first must run the
        // FirebaseApp configure method
        FirebaseApp.configure()
        // We call auth and firestore to get access to these frameworks authController = Auth.auth()
        database = Firestore.firestore()
        locationList = [Location]()
        super.init()
        // This will START THE PROCESS of signing in with an anonymous account // The closure will not execute until its recieved a message back which can be // any time later
        authController.signInAnonymously() { (authResult, error) in
            guard authResult != nil else {
                fatalError("Firebase authentication failed") }
            // Once we have authenticated we can attach our listeners to // the firebase firestore
            self.setUpLocationListener()
        }
    }
    
    func setUpLocationListener() {
        locationRef = database.collection("locations")
        locationRef?.addSnapshotListener{(querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("Error fetching locations: \(error!)")
                return
            }
            self.parseLocationsSnapshot(snapshot: querySnapshot)
    }
        
        func parseLocationsSnapshot(snapshot: QuerySnapshot) {
            snapshot.documentChanges.forEach { (change) in
                let locationID = change.document.documentID
                print(locationID)
                
                var parsedLocation: Location?
                
                do {
                    parsedLocation = try change.document.data(as: Location.self)
                }
                catch {
                    print("Unable to Decode Locations. Is the Location malformed?")
                    return
                }
                
                guard let location = parsedLocation else {
                print("Document doesn't exist")
                return
                }
                
                location.id = locationID
                if change.type == .added {
                    locationList.append(location)
                } else if change.type == .modified {
                    let index = getLocationIndexById(locationID)!
                    locationList[index] = location
                } else if change.type == .removed {
                    if let index = getLocationById(locationID) {
                    locationList.remove(at: index)
                }
            }
        }
        
        listeners.invoke {(listener) in
            if listener.listenerType == ListenerType.location {
                listener.onLocationChange(change: .update, locations: locationList)
            }
        }
    }
        
        
    // MARK:- Utility Functions

        func getLocationIndexById(_ id: String) -> Int? {
            if let location = getLocationById(id) {
                return locationList.firstIndex(of: location)
            }
            return nil
        }
        
        func getLocationById(_ id: String) -> Location? {
            for location in locationList {
                if location.id == id {
                    return location
                }
            }
            return nil
        }
    
    func cleanup() {
        
    }
        
    func addLocation(id: String, name: String, date: String, time: String, lat: Double, long: Double) -> Location {
        let location = Location()
        location.name = name
        location.date = date
        location.time = time
        location.lat = lat
        location.long = long
        
        do {
            if let locRef = try locationRef?.addDocument(from: location) {
                location.id = locRef.documentID
            }
        }
        catch {
            print("Failed to serialize Location")
        }
        return location
    }
    
    
    func deleteLocation(location: Location) {
        if let locationID = location.id {
            locationRef?.document(locationID).delete()
        }
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.location {
            listener.onLocationChange(change: .update, locations: locationList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
}
}
