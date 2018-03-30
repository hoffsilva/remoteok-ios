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
        Connection.fetchData { (arrayOfJobOportunities) in
            for job in arrayOfJobOportunities as! Array<Any>{
                let currentJob = JobOportunity()
                let jobDictionary = job as! [String:Any]
                currentJob.position = jobDictionary["position"] as? String
                currentJob.slug = jobDictionary["slug"] as? String
                currentJob.id = jobDictionary["id"] as? String
                currentJob.epoch = jobDictionary["epoch"] as? String
                currentJob.descriptionValue = jobDictionary["descriptionValue"] as? String
                currentJob.date = jobDictionary["date"] as? String
                currentJob.logo = jobDictionary["logo"] as? String
                currentJob.tags = jobDictionary["tags"] as? [String]
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
        job.tags = currentJob.tags! as NSObject
        job.company = currentJob.company
        job.url = currentJob.url
        try! managedContext.save()
    }
    
    func getAllOpportunities() {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allOportunities") as? NSFetchRequest<Opportunity> else {
            return
        }
        
        do {
           arrayOfOpportunity = try managedContext.fetch(fetch)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func filterJobsBy(tag: String) {
        
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
        jobFavorite.tags = job.tags! as NSObject
        jobFavorite.company = job.company
        jobFavorite.url = job.url
        try! managedContext.save()
    }
    
    func removeJobFromFavorite(_ job: OportunityFavorite) {
        managedContext.delete(job)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getAllFavoriteOpportunities() {
        guard let model = managedContext.persistentStoreCoordinator?.managedObjectModel, let fetch = model.fetchRequestTemplate(forName: "allFavoriteOportunities") as? NSFetchRequest<OportunityFavorite> else {
            return
        }
        
        do {
            arrayOfFavoriteOpportunity = try managedContext.fetch(fetch)
        } catch let error as NSError {
            print(error)
        }
    }
    
}
