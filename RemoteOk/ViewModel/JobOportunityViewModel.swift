//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

protocol JobOppotunityFavoriteDelegate: class  {
    func favoritesJobsLoaded()
}

protocol JobOpportunityDelegate: class {
    func jobOpportunitiesLoaded()
}

class JobOportunityViewModel {
    
    weak var delegate: JobOpportunityDelegate!
    weak var favoriteDelegate: JobOppotunityFavoriteDelegate!
    
    var managedContext = CoreDataStack().persistentContainer.viewContext
    var arrayOfOpportunity = [Opportunity]()
    var arrayOfFavoriteOpportunity = [OportunityFavorite]()
    var arrayOfFilters: [String]!
    var currentJob: Int!
    var currentJobFavorite: Int!
    
    
    func saveJobFromJSON(_ currentJob: JobOportunity) {
        let jobToSave = NSEntityDescription.entity(forEntityName: "Opportunity", in: managedContext)
        guard let jts = jobToSave else {
            return
        }
        let job = Opportunity(entity: jts, insertInto: managedContext)
        job.position = currentJob.position
        job.slug = currentJob.slug
        job.id = currentJob.id
        job.epoch = currentJob.epoch
        job.desc = currentJob.descriptionValue
        job.date = currentJob.date
        job.logo = currentJob.logo
        job.tags = currentJob.tags
        job.company = currentJob.company
        job.url = currentJob.url
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func getAllOpportunities() {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allOportunities") as? NSFetchRequest<Opportunity> else {
            return
        }
        
        do {
            arrayOfOpportunity = try managedContext.fetch(fetch)
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }
    
    func deleteAllOpportunities() {
        var dataToDelete = [Opportunity]()
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allOportunities") as? NSFetchRequest<Opportunity> else {
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
    
    func filterJobsBy(tags: [String]) {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allOportunities") as? NSFetchRequest<Opportunity> else {
            return
        }
        do {
            let opportunities = try managedContext.fetch(fetch)
            arrayOfOpportunity = []
            for job in opportunities {
                let orderedTags = job.tags?.sorted()
                let selectedTags = tags.sorted()
                for tag in selectedTags {
                    if (orderedTags?.contains(tag))! {
                        arrayOfOpportunity.append(job)
                    }
                }
            }
            self.delegate.jobOpportunitiesLoaded()
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }
    
    
    
    
    func markJobAsFavorite(_ job: Opportunity, completion: (_ success: String?) -> Void) {
        var exists = false
        let predicate = NSPredicate(format: "%K == %@",#keyPath(Opportunity.id), job.id!)
        let fetchRequest: NSFetchRequest<OportunityFavorite> = OportunityFavorite.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let filteredJob = try managedContext.fetch(fetchRequest)
            if filteredJob.first == nil {
                exists = false
            } else {
                exists = true
            }
        } catch let error as NSError {
            print("Error when try fetch all filtered tags " + error.description)
        }
        
        if exists {
            completion("This job already added to favorites jobs list.")
        } else {
            let jobToFavorite = NSEntityDescription.entity(forEntityName: "OpportunityFavorite", in: managedContext)
            guard let jtf = jobToFavorite else {
                return
            }
            let jobFavorite = OportunityFavorite(entity: jtf, insertInto: managedContext)
            jobFavorite.position = job.position
            jobFavorite.slug = job.slug
            jobFavorite.id = job.id
            jobFavorite.epoch = job.epoch
            jobFavorite.desc = job.desc
            jobFavorite.date = job.date
            jobFavorite.logo = job.logo
            jobFavorite.tags = job.tags
            jobFavorite.company = job.company
            jobFavorite.url = job.url
            jobFavorite.favorite = true
            do {
                try managedContext.save()
                getAllFavoriteOpportunities()
                completion("This job was added to favorites jobs list.")
            } catch let error as NSError {
                print("Error when try mark opportunity as favorite opportunity " + error.description)
            }
        }
        
    }
    
    func removeJobFromFavorite(_ job: OportunityFavorite) {
        managedContext.delete(job)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error when try delete favorite opportunity " + error.description)
        }
    }
    
    func getAllFavoriteOpportunities() {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allFavoriteOpportunities") as? NSFetchRequest<OportunityFavorite> else {
            return
        }
        
        do {
            arrayOfFavoriteOpportunity = try managedContext.fetch(fetch)
           // favoriteDelegate.favoritesJobsLoaded()
        } catch let error as NSError {
            print("Error when try delete all favorite opportunities " + error.description)
        }
    }
    
    
    func getJob() -> Opportunity {
        return arrayOfOpportunity[currentJob]
    }
    
    func getFavoriteJob() -> OportunityFavorite {
        return arrayOfFavoriteOpportunity[currentJobFavorite]
    }
    
    
}


