//
//  AppDelegate.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/7/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            let realm = try Realm()
        } catch {
            print("Error initialising new Realm, \(error)")
        }
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

}

