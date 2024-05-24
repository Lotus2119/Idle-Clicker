//
//  AppDelegate.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 24/05/2024.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationWillTerminate(_ application: UIApplication) {
        print("AppDelegate: Application will terminate")
        NotificationCenter.default.post(name: .appWillTerminate, object: nil)
    }
}

extension Notification.Name {
    static let appWillTerminate = Notification.Name("appWillTerminate")
}
