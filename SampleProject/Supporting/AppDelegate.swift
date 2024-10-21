//
//  AppDelegate.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = CategoryViewController()
        window.makeKeyAndVisible()
        
        return true
    }
}
