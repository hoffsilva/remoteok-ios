//
//  PushNotificationManager.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-20.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import UserNotifications

 class PushNotificationManager {

     private let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
     private let persistenceManager: PersistenceManager

     internal init(persistenceManager: PersistenceManager) {
         self.persistenceManager = persistenceManager
     }

     func requestAuthorization() {

         UNUserNotificationCenter
             .current()
             .requestAuthorization(
             options: authOptions,
             completionHandler: { [weak self] authorize, error in
                 self?.persistenceManager.create(authorize, forKey: .pushNotification)
             }
         )
     }

 }
