//
//  AppDelegate.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(withIdentifier: "ViewController")
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        return true
    }
}

