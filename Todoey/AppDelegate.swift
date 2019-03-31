//
//  AppDelegate.swift
//  Todoey
//
//  Created by Melis Kaya on 25.03.2019.
//  Copyright © 2019 Melis Kaya. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
//            try realm.write {
//                realm.add(data)
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
        return true
    }


}

