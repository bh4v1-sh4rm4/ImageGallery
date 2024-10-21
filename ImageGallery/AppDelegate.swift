//
//  AppDelegate.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 20/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setupRootVC()
        return true
    }
    func setupRootVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }


}

