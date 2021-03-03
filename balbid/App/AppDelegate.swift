//
//  AppDelegate.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import IQKeyboardManagerSwift
import MOLH
import AppRouter
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appRouter: AppRouter?

    var appWindow: UIWindow? {
        get {
            if #available(iOS 13.0, *) {
                return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
            } else {
                return window
            }
        }
    }

    var remoteNotificationUserInfo: [String: Any]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupApp(with: launchOptions)
//        UIFont.familyNames.forEach({ familyName in
//               let fontNames = UIFont.fontNames(forFamilyName: familyName)
//               print(familyName, fontNames)
//           })
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

    private func setupApp(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage(Locale.current.languageCode ?? "en")
        if #available(iOS 13.0, *) {
            print("Scene delegate will start app!")
        } else {
            window = UIWindow()
            startApp(using: window!)
            remoteNotificationUserInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: Any]
        }
        IQKeyboardManager.shared.enable = true
        ReachabilityManager.shared.observe()
    }

    func startApp(using window: UIWindow) {
        self.window = window
        appRouter = AppRouter(window: window, rootViewController: nil)
        appRouter?.navigate(to: .splashRoute)
        LocationManager.shared.startTracking(router: appRouter!)
    }

    func refreshApp() {
        // refresh some data after app become active
    }

}

extension UIViewController: Routable {

    weak public var router: AppRouter?{
        get{
            return (UIApplication.shared.delegate as? AppDelegate)?.appRouter
        }
    }
}
