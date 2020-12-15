//
//  AppDelegate.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import IQKeyboardManagerSwift
import MOLH
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appRouter: AppRouter?
    
    var appWindow: UIWindow?{
        get{
            if #available(iOS 13.0, *) {
                return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
            }else{
                return window
            }
        }
    }
    
    var remoteNotificationUserInfo: [String: Any]?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupApp(with: launchOptions)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        refreshApp()
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func setupApp(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage(Locale.current.languageCode ?? "en")
        if #available(iOS 13.0, *) {
            print("Scene delegate will start app!")
        }else{
            window = UIWindow()
            startApp(using: window!)
            remoteNotificationUserInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: Any]
        }
    }
    
    func startApp(using window: UIWindow){
        self.window = window
        appRouter = AppRouter(window: window, rootViewController: nil)
        appRouter?.navigate(to:.splashViewController)

//        LocationManager.shared.startTracking(router: appRouter!)
    }
    
    
    func refreshApp(){
        // refresh some data after app become active
    }
    
    
}

