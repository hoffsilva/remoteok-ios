//
//  TagsViewModel.swift
//
//
//  Created by Hoff Silva on 06/04/2018.
//

import CoreData
import Foundation

protocol TagDelegate: class {
    func tagsLoaded()
}

class TagsViewModel {
    weak var tagDelegate: TagDelegate!
    var managedContext = CoreDataStack().persistentContainer.viewContext
    var arrayOfTags = Set<String>()
    var tags = [Tag]()
    var selectedTags = [String]()

    func getTagsFromJobs() {
        do {
            let opportunities = try managedContext.fetch(
                Extensions.getFetchRequestBy(
                    templateName: Constants.frtallOportunities,
                    type: Opportunity.self
                )
            )
            arrayOfTags.removeAll()
            for job in opportunities {
                if let tags = job.tags {
                    for tag in tags {
                        arrayOfTags.insert(tag.uppercased())
                    }
                }
            }
            deleteAllTags()
            let sortedArrayOfTags = arrayOfTags.sorted()
            for tag in sortedArrayOfTags {
                saveTag(tagFromJobs: tag)
            }
            getTags()
            tagDelegate.tagsLoaded()
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }

    func getTags() {
        do {
            let tagsFromCoreData = try managedContext.fetch(
                Extensions.getFetchRequestBy(
                    templateName: Constants.frtallTags,
                    type: Tag.self
                )
            )
            tags = tagsFromCoreData
        } catch let error as NSError {
            print("Error when try fetch all tags " + error.description)
        }
    }

    func saveTag(tagFromJobs: String) {
        let tagToSave = NSEntityDescription.entity(forEntityName: Constants.enTag, in: managedContext)
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
        do {
            dataToDelete = try managedContext.fetch(
                Extensions.getFetchRequestBy(
                    templateName: Constants.frtallTags,
                    type: Tag.self
                )
            )
            for jobToDelete in dataToDelete {
                managedContext.delete(jobToDelete)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Error when try delete all opportunities " + error.description)
        }
    }

    func serchTag(string: String) {
        tags = []
        let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Tag.name), string)
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.predicate = predicate

        do {
            let filteredTags = try managedContext.fetch(fetchRequest)
            tags = filteredTags
            tagDelegate.tagsLoaded()
        } catch let error as NSError {
            print("Error when try fetch all filtered tags " + error.description)
        }
    }

    func updateTag(tag: Tag) {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Tag.name), tag.name!)
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
                tagDelegate.tagsLoaded()
            } catch let error as NSError {
                print(error)
            }

        } catch let error as NSError {
            print("Error when try fetch all filtered tags " + error.description)
        }
    }
}
