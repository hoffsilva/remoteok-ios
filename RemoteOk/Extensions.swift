//
//  Extensions.swift
//  RemoteOk
//
//  Created by Hoff Silva on 17/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import CoreData
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
        let formatter = DateFormatter()
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

    static func getFetchRequestBy<Element>(templateName: String, type _: Element.Type) -> NSFetchRequest<Element> {
        guard let model = CoreDataStack().persistentContainer.viewContext.persistentStoreCoordinator?.managedObjectModel,
            let fetch = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<Element> else {
            return NSFetchRequest(entityName: "")
        }
        return fetch
    }
}

extension UIViewController {
    var activityIndicatorTag: Int { return 999_999 }
    func pleaseWaiting() {
        DispatchQueue.main.async {
            let overlayView = UIView(frame: self.view.bounds)
            overlayView.alpha = 0
            overlayView.tag = self.activityIndicatorTag
            overlayView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.alpha = 1.0
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            overlayView.addSubview(activityIndicator)
            self.view.addSubview(overlayView)
            self.view.bringSubview(toFront: overlayView)
            UIView.animate(withDuration: 0.9, delay: 0.0, options: .curveEaseIn, animations: {
                overlayView.alpha = 0.6
            }, completion: nil)
            activityIndicator.startAnimating()
        }
    }

    func removeActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == self.activityIndicatorTag }
            ).first {
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
                    activityIndicator.alpha = 0
                }) { _ in
                    activityIndicator.removeFromSuperview()
                }
            }
        }
    }
}
