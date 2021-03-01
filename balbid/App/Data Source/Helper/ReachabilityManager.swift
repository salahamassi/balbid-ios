//
//  ReachabilityManager.swift
//  WinchEngine
//
//  Created by Salah Amassi on 5/4/20.
//  Copyright © 2020 winch. All rights reserved.
//

import Network
import UIKit

public class ReachabilityManager: NSObject {

   public class var shared: ReachabilityManager {
        struct Static {
            static let instance = ReachabilityManager()
        }
        return Static.instance
    }

    public var isNetworkReachable: Bool = true

    public static let networkNotificationName = Notification.Name("networkNotification")

    func observe() {
        observeNetworkReachability()
    }

    private func observeNetworkReachability() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                if !self.isNetworkReachable {
                    DispatchQueue.main.async {
                        self.isNetworkReachable = true
                        NotificationCenter.default.post(name: ReachabilityManager.networkNotificationName, object: nil, userInfo: ["status": true])
                    }
                }
            } else {
                print("No connection.")
                DispatchQueue.main.async {
                    self.isNetworkReachable = false
                    NotificationCenter.default.post(name: ReachabilityManager.networkNotificationName, object: nil, userInfo: ["status": false])
                }
            }
            print(path.isExpensive)

        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
