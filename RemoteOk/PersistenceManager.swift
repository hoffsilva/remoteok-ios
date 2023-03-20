//
//  PersistenceManager.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-20.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

enum PersistenceManagerKey: String {
    case pushNotification
}

class PersistenceManager {
    
    func create(_ value: Any?, forKey defaultName: PersistenceManagerKey) {
        UserDefaults.standard.set(value, forKey: defaultName.rawValue)
    }
    
    func create(_ value: Any?, forDynamicKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }
    
    func read(forKey defaultName: PersistenceManagerKey) -> Any? {
        UserDefaults.standard.value(forKey: defaultName.rawValue)
    }
    
    func read(forDynamicKey defaultName: String) -> Any? {
        UserDefaults.standard.value(forKey: defaultName)
    }
    
    func update(_ value: Any?, forKey defaultName: PersistenceManagerKey) {
        UserDefaults.standard.set(value, forKey: defaultName.rawValue)
    }
    
    func delete(forKey defaultName: PersistenceManagerKey) {
        UserDefaults.standard.set(nil, forKey: defaultName.rawValue)
    }
    
}
