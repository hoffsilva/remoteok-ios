//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import CoreData

class JobOportunityViewModel {
    
    var managedContext = CoreDataStack().persistentContainer.viewContext
    var arrayOfOpportunity = [Opportunity]()
    var arrayOfFavoriteOpportunity = [OportunityFavorite]()
    
    func loadJobsFromRemoteOK() {
        deleteAllOpportunities()
        Connection.fetchData { (arrayOfJobOportunities) in
            for job in arrayOfJobOportunities as! Array<Any>{
                var currentJob = JobOportunity()
                let jobDictionary = job as! [String:Any]
                currentJob.position = jobDictionary["position"] as? String
                currentJob.slug = jobDictionary["slug"] as? String
                currentJob.id = jobDictionary["id"] as? String
                currentJob.epoch = jobDictionary["epoch"] as? String
                currentJob.descriptionValue = jobDictionary["description"] as? String
                currentJob.date = jobDictionary["date"] as? String
                currentJob.logo = jobDictionary["logo"] as? String
                currentJob.tags = jobDictionary["tags"] as! [String]
//                for tag in jobDictionary["tags"] as! [String] {
//                    if let ta = tag as String {
//                        currentJob.tags += "\(tag as String),"
//                        print(tag)
//                    }
//                }
                //currentJob.tags = jobDictionary["tags"] as? [String]
                currentJob.company = jobDictionary["company"] as? String
                currentJob.url = jobDictionary["url"] as? String
                self.saveJobFromJSON(currentJob)
            }
        }
    }
    
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
    
    func filterJobsBy(tag: String) {
        
        let fetchRequest = NSFetchRequest<Opportunity>(entityName: "Opportunity")
        //fetchRequest
    }
    
    
    func markJobAsFavorite(_ job: Opportunity) {
        let jobToFavorite = NSEntityDescription.entity(forEntityName: "OpportunityFavorite", in: managedContext)
        guard let jtf = jobToFavorite else {
            return
        }
        let jobFavorite = Opportunity(entity: jtf, insertInto: managedContext)
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
        do {
            try managedContext.save()
        } catch let error as NSError {
             print("Error when try mark opportunity as favorite opportunity " + error.description)
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
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allFavoriteOportunities") as? NSFetchRequest<OportunityFavorite> else {
            return
        }
        
        do {
            arrayOfFavoriteOpportunity = try managedContext.fetch(fetch)
        } catch let error as NSError {
            print("Error when try delete all favorite opportunities " + error.description)
        }
    }
    
}