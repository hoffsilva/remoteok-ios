//
//  AppDelegate.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let persistenceManager = Container.makePersistenceManager()
    private let fcmTokenUseCase = Container.makeSaveFCMTokenUseCase()
    private let pushNotificationManager = Container.makePushNotificationManager()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        pushNotificationManager.requestAuthorization()
        application.registerForRemoteNotifications()
        return true
    }
    
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let isPushNotificationAuthorized = persistenceManager.read(forKey: .pushNotification) as? Bool,
        let token = fcmToken,
        isPushNotificationAuthorized else { return }
        fcmTokenUseCase.saveFCMToken(token: token)
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
}

@main
struct AppyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                JobsListViewUI(jobsViewModel: Container.makeJobsViewModel())
            }
            .tint(.primary)
        }
    }
}
