//
//  Constants.swift
//  RemoteOk
//
//  Created by Cast Group on 15/02/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

enum Constants {
    
    static let baseURL = "https://abroadjobs.azurewebsites.net/"
    
    static let jobsPath = "jobs/%@"
    static let filteredJobsPath = "jobs/filteredJobs/%@/%@"
    static let fcmtoken = "fcmtoken"
    static let urlOfReachabilityTest = "www.google.com"
    
    //Fetch request templates
    static let frtallOportunities = "allOportunities"
    static let frtallTags = "allTags"
    
    //Entity Names
    static let enTag = "Tag"
}
