//
//  AppDelegate.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIFont.familyNames.forEach { name in
//            let fonts = UIFont.fontNames(forFamilyName: name)
            for fontName in UIFont.fontNames(forFamilyName: name) {
                print("\n\(fontName)")
            }
        }
        
        let rootViewController = MainTabBarController.fromStoryboard
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
