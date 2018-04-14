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
    var tags = [""]
    var selectedTags = [String]()
    
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
            populateTags()
            self.tagDelegate.tagsLoaded()
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }
    
    func populateTags() {
        tags = []
        for tag in arrayOfTags {
            tags.append(tag)
        }
    }
    
    func serchTag(string: String) {
        tags = []
        for tag in arrayOfTags {
            if tag.uppercased().contains(string) {
                tags.append(tag)
            }
        }
    }
}
