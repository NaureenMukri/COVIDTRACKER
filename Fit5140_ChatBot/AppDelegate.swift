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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //replace the XXXXXs with your own id
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:1d8c274c-d018-453e-93f3-c3b4decf8185")
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        //change "botBot" to the name of your Lex bot
        let chatConfig =  AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: "botBot", botAlias: "$LATEST")
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
        
        FirebaseApp.configure()
        
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

