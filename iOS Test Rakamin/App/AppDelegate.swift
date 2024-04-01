//
//  AppDelegate.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import os.log

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFirebase()
        setupUserNotifications()
        registerForRemoteNotifications(application)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // MARK: - Firebase Setup
    private func setupFirebase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    // MARK: - User Notifications
    private func setupUserNotifications() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
    }
    
    // MARK: - Remote Notifications
    private func registerForRemoteNotifications(_ application: UIApplication) {
        application.registerForRemoteNotifications()
    }
    
}

// MARK: - Messaging Delegate

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else {
            return
        }
        print("Token: \(token)")
    }
    
}

// MARK: - User Notification Center Delegate

extension AppDelegate: UNUserNotificationCenterDelegate {
}
