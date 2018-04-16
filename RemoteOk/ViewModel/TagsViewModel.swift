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
    var tags = [Tag]()
    var selectedTags = [String]()
    
    func getTagsFromJobs() {
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
            deleteAllTags()
            for tag in arrayOfTags {
                 saveTag(tagFromJobs: tag )
            }
            getTags()
            self.tagDelegate.tagsLoaded()
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }
    
    func getTags() {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allTags") as? NSFetchRequest<Tag> else {
            return
        }
        do {
            let tagsFromCoreData = try managedContext.fetch(fetch)
            tags = tagsFromCoreData
        } catch let error as NSError {
            print("Error when try fetch all tags " + error.description)
        }
    }
    
    func saveTag(tagFromJobs: String) {
        let tagToSave = NSEntityDescription.entity(forEntityName: "Tag", in: managedContext)
        guard let tts = tagToSave else {
            return
        }
        let tag = Tag(entity: tts, insertInto: managedContext)
        tag.isSelected = false
        tag.name = tagFromJobs.uppercased()
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllTags() {
        var dataToDelete = [Tag]()
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allTags") as? NSFetchRequest<Tag> else {
            return
        }
        do {
            dataToDelete = try managedContext.fetch(fetch)
            for jobToDelete in dataToDelete {
                managedContext.delete(jobToDelete)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Error when try delete all opportunities " + error.description)
        }
    }
//    func populateTags() {
//        tags = []
//        for tag in arrayOfTags {
//            tags.append(tag)
//        }
//    }
    
    func serchTag(string: String) {
        tags = []
        let predicate = NSPredicate(format: "%K CONTAINS[cd] %@",#keyPath(Tag.name), string)
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let filteredTags = try managedContext.fetch(fetchRequest)
            tags = filteredTags
            self.tagDelegate.tagsLoaded()
        } catch let error as NSError {
             print("Error when try fetch all filtered tags " + error.description)
        }
    }
    
    func updateTag(tag: Tag) {
        let predicate = NSPredicate(format: "%K == %@",#keyPath(Tag.name), tag.name!)
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let currentTag = try managedContext.fetch(fetchRequest)
            let tag = currentTag.first
            if (tag?.isSelected)! {
                tag?.isSelected = false
            } else {
                tag?.isSelected = true
            }
            do {
                try managedContext.save()
                self.tagDelegate.tagsLoaded()
            } catch let error as NSError {
                print(error)
            }
            
        } catch let error as NSError {
            print("Error when try fetch all filtered tags " + error.description)
        }
    }
}
