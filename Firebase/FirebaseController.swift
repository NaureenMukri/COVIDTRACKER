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
    
    
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var locationRef: CollectionReference?
    var symptomRef: CollectionReference?
    var symptomList: [Symptoms]
    var locationList: [Location]
    
    override init() {
        // To use Firebase in our application we first must run the
        // FirebaseApp configure method
        // We call auth and firestore to get access to these frameworks
        authController = Auth.auth()
        database = Firestore.firestore()
        locationList = [Location]()
        symptomList = [Symptoms]()
        super.init()
        // This will START THE PROCESS of signing in with an anonymous account // The closure will not execute until its recieved a message back which can be // any time later
//        authController.signInAnonymously() { (authResult, error) in
//            guard authResult != nil else {
//                fatalError("Firebase authentication failed") }
            // Once we have authenticated we can attach our listeners to // the firebase firestore
            self.setUpLocationListener()
            self.setUpSymptomListener()
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
    }
    
    func setUpSymptomListener() {
        symptomRef = database.collection("symptoms")
        symptomRef?.addSnapshotListener{(querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("Error fetching symptoms: \(error!)")
                return
            }
            self.parseSymptomSnapshot(snapshot: querySnapshot)
        }
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
                    if let index = getLocationIndexById(locationID) {
                        locationList.remove(at: index)
                }
            }
        
        listeners.invoke {(listener) in
            if listener.listenerType == ListenerType.location {
                listener.onLocationChange(change: .update, locations: locationList)
            }
        }
        }
        }
    
    
    func parseSymptomSnapshot(snapshot: QuerySnapshot) {
        snapshot.documentChanges.forEach { (change) in
            let symptomID = change.document.documentID
            print(symptomID)
            
            var parsedSymptom: Symptoms?
            
            do {
                parsedSymptom = try change.document.data(as: Symptoms.self)
            }
            catch {
                print("Unable to Decode Symptoms. Is the Symptom malformed?")
                return
            }
            
            guard let symptom = parsedSymptom else {
            print("Document doesn't exist")
            return
            }
            
            symptom.id = symptomID
            if change.type == .added {
                symptomList.append(symptom)
            } else if change.type == .modified {
                let index = getSymptomIndexById(symptomID)!
                symptomList[index] = symptom
            } else if change.type == .removed {
                if let index = getSymptomIndexById(symptomID) {
                    symptomList.remove(at: index)
            }
        }
    
    listeners.invoke {(listener) in
        if listener.listenerType == ListenerType.symptoms {
            listener.onSymptomChange(change: .update, symptoms: symptomList)
        }
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
    
    
        func getSymptomIndexById(_ id: String) -> Int? {
            if let symptom = getSymptomById(id) {
                return symptomList.firstIndex(of: symptom)
            }
            return nil
        }
    
        func getSymptomById(_ id: String) -> Symptoms? {
            for symptom in symptomList {
                if symptom.id == id {
                    return symptom
                }
            }
            return nil
        }
        
    // MARK:- Required Database Functions
    
    func cleanup() {
        
    }
        
    func addLocation(name: String, date: String, time: String, lat: Double, long: Double) -> Location {
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
    
    func addSymptoms(date: String, feeling: String, symptoms: [String]) -> Symptoms {
        let symptom = Symptoms()
        symptom.date = date
        symptom.feeling = feeling
        symptom.symptoms = symptoms
        
        do {
            if let symRef = try symptomRef?.addDocument(from: symptom) {
                symptom.id = symRef.documentID
            }
        }
        catch {
            print("Failed to serialize Symptom")
        }
        return symptom
    }
    
    func deleteSymptoms(symptom: Symptoms) {
        if let symptomId = symptom.id {
            symptomRef?.document(symptomId).delete()
        }
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.location {
            listener.onLocationChange(change: .update, locations: locationList)
        }
        
        if listener.listenerType == ListenerType.symptoms {
            listener.onSymptomChange(change: .update, symptoms: symptomList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
}

