//
//  AppDelegate.swift
//  Fit5140_ChatBot
//
//  Created by Nivedita Tomar on 16/10/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import AWSCore
import AWSLex
import AWSCognito
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var databaseController: DatabaseProtocol?
    
    override init() {
       // Firebase Init
       FirebaseApp.configure()
    }
    
    // Initialising the connection of Firebase and AWS
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:1d8c274c-d018-453e-93f3-c3b4decf8185")
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        //connecting to the bot by defining the name of your Lex bot used to set up the bot
        let chatConfig =  AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: "chatty", botAlias: "$LATEST")
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
        
        databaseController = FirebaseController()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

