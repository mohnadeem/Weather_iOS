//
//  AppDelegate.swift
//  Weather
//
//  Created by Muhammad Nadeem on 12/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // set navigation style
        AppConfig.setNavigationStyle()

        return true
    }

}

