//
//  AppDelegate.swift
//  Todoey
//
//  Created by Kaiden on 23/6/2018.
//  Copyright © 2018年 KNA Workshop. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()

            }catch{
           print("Error install realm \(error)")
        }

        return true
    }
  
}

