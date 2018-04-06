//
//  TagsViewModel.swift
//  
//
//  Created by Hoff Silva on 06/04/2018.
//

import Foundation
import CoreData

protocol TagDelegate : class {
    func tagsLoaded()
}

class TagsViewModel {
    var managedContext = CoreDataStack().persistentContainer.viewContext
    weak var tagDelegate : TagDelegate!
    var arrayOfTags = Set<String>()
    
    func getTags() {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allOportunities") as? NSFetchRequest<Opportunity> else {
            return
        }
        do {
            let opportunities = try managedContext.fetch(fetch)
            arrayOfTags = []
            for job in opportunities {
                for tag in job.tags! {
                    arrayOfTags.insert(tag)
                }
            }
            self.tagDelegate.tagsLoaded()
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }
}
