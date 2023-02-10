//
//  AppDelegate.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

@main
struct AppyApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                JobsListViewUI(jobsViewModel: Container.makeJobsViewModel())
            }
            .tint(.primary)
        }
    }
}
