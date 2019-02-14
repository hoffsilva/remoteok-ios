//
//  ConstatsUtil.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 05/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SwiftyPlistManager

class ConstantsUtil {
    
    private static let plist = SwiftyPlistManager.shared
    private static let endOfURL = "-jobs.json"
    private static let mainURL =  plist.fetchValue(for: "mainURL", fromPlistWithName: "Constants") as! String
    
    public static func remoteJobsURL() -> String {
        return "\(mainURL)-api\(endOfURL)"
    }
    
    public static func devJobsURL() -> String {
        let dev = plist.fetchValue(for: "dev", fromPlistWithName: "Constants") as! String
        return "\(mainURL)\(dev)\(endOfURL)"
    }
    
    public static func supportJobsURL() -> String {
        let support = plist.fetchValue(for: "support", fromPlistWithName: "Constants") as! String
        return "\(mainURL)\(support)\(endOfURL)"
    }
    
    public static func marketingJobsURL() -> String {
        let marketing = plist.fetchValue(for: "marketing", fromPlistWithName: "Constants") as! String
        return "\(mainURL)\(marketing)\(endOfURL)"
    }
    
    public static func designJobsURL() -> String {
        let design = plist.fetchValue(for: "design", fromPlistWithName: "Constants") as! String
        return "\(mainURL)\(design)\(endOfURL)"
    }
    
    public static func nonTechJobsURL() -> String {
        let nonTech = plist.fetchValue(for: "non-tech", fromPlistWithName: "Constants") as! String
        return "\(mainURL)\(nonTech)\(endOfURL)"
    }
    
    public static func englishTeacherJobsURL() -> String {
        let englishTeacher = plist.fetchValue(for: "english-teacher", fromPlistWithName: "Constants") as! String
        return "\(mainURL)\(englishTeacher)\(endOfURL)"
    }
    
    public static func searchJobBy(tags: [String]) -> String {
        var URL =  mainURL
        for tag in tags {
            if tags.first == tag {
                URL.append("-\(tag)")
            } else {
                URL.append("+\(tag)")
            }
        }
        URL.append(endOfURL)
        return URL
    }
    
    public static func cryptoCurrency() -> String {
        //cryptoCurrency
        let cryptoCurrency = plist.fetchValue(for: "cryptoCurrency", fromPlistWithName: "Constants") as! String
        return cryptoCurrency
    }
    
    public static func getAllJobs() -> String {
        let allJobs = plist.fetchValue(for: "allJobs", fromPlistWithName: "Constants") as! String
        return allJobs
    }
}
