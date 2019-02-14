//
//  Extensions.swift
//  RemoteOk
//
//  Created by Hoff Silva on 17/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import UIKit

class Extensions {
    static func formatDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dString = dateString.prefix(10)
        guard let date = dateFormatter.date(from: String(dString)) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        return date
    }
    
    static func getYesterday() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dString = "\(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)".prefix(10)
        guard let date = dateFormatter.date(from: String(dString)) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        return date
    }
    
    static func getWeekNumber(date: String) -> Int {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dString = date.prefix(10)
        guard let todaydate = formatter.date(from: String(dString)) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekOfYear, from: todaydate)
        let weekNumber = myComponents.weekOfYear
        return weekNumber!
    }
}
