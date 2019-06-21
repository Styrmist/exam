//
//  AppDelegate.swift
//  exam-bare
//
//  Created by Kirill on 6/16/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        if let savedCountries = defaults.object(forKey: "savedCountries") as? Data {
            let decoder = JSONDecoder()
            if let loadedCountries = try? decoder.decode([String].self, from: savedCountries) {
                Constants.savedCountries = loadedCountries
            }
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Constants.savedCountries) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedCountries")
        }
    }
}
