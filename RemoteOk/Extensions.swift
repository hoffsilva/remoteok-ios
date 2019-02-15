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
     var activityIndicatorTag: Int { return 999999 }
    
    func startActivityIndicator(
        style: UIActivityIndicatorViewStyle = .gray,
        location: CGPoint? = nil) {
        
        //Set the position - defaults to `center` if no`location`
        
        //argument is provided
        
        let loc = location ?? self.view.center
        
        //Ensure the UI is updated from the main thread
        
        //in case this method is called from a closure
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            //Add the tag so we can find the view in order to remove it later
            
            activityIndicator.tag = self.activityIndicatorTag
            //Set the location
            
            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            //Start animating and add the view
            
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        
        //Again, we need to ensure the UI is updated from the main thread!
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }

    
}
