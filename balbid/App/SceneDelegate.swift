//
//  SceneDelegate.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        (UIApplication.shared.delegate as? AppDelegate)?.startApp(using: window)
        (UIApplication.shared.delegate as? AppDelegate)?.remoteNotificationUserInfo = connectionOptions.notificationResponse?.notification.request.content.userInfo as? [String: Any]
        self.window = window
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.refreshApp()
    }

}
