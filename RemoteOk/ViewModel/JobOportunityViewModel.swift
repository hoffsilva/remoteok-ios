//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Alamofire
import CoreData
import Foundation

protocol JobOppotunityFavoriteDelegate: class {
    func favoritesJobsLoaded()
}

protocol JobOpportunityDelegate: class {
    func jobOpportunitiesLoaded()
    func jobsFiltered()
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
        job.position = currentJob.jobTitle
        job.slug = ""
        job.id = ""
        job.epoch = currentJob.source
        job.desc = currentJob.jobDescription
        job.date = "2018-07-30T20:53:26-07:00"
        job.logo = currentJob.companyLogoURL
        job.tags = currentJob.tagsStrings?.split(separator: ",") as? [String]
        job.company = currentJob.companyName
        job.url = currentJob.applyURL
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }

    func getAllOpportunities() {
        do {
            var fetch = Extensions.getFetchRequestBy(
                templateName: Constants.frtallOportunities,
                type: Opportunity.self
            )
            fetch = Opportunity.fetchRequest()
            arrayOfOpportunity = try managedContext.fetch(fetch)
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }

    func deleteAllOpportunities() {
        var dataToDelete = [Opportunity]()
        do {
            dataToDelete = try managedContext.fetch(
                Extensions.getFetchRequestBy(
                    templateName: Constants.frtallOportunities,
                    type: Opportunity.self
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

    func filterJobsBy(tags: [String]) {
        do {
            let opportunities = try managedContext.fetch(
                Extensions.getFetchRequestBy(
                    templateName: Constants.frtallOportunities,
                    type: Opportunity.self
                )
            )
            arrayOfOpportunity = []

            if tags.first == "cryptojobslist" {
                for job in opportunities {
                    if job.epoch == tags.first {
                        arrayOfOpportunity.append(job)
                    }
                }
                delegate.jobsFiltered()
                return
            }
            for job in opportunities {
                if job.epoch == tags.first {
                    arrayOfOpportunity.append(job)
                }
                if let orderedTags = job.tags?.sorted() {
                    var newOrderedTags = [String]()
                    for ot in orderedTags {
                        newOrderedTags.append(ot.uppercased())
                    }
                    print(newOrderedTags)
                    let selectedTags = tags.sorted()
                    print(selectedTags)
                    for tag in selectedTags {
                        if newOrderedTags.contains(tag) {
                            print("tag found!")
                            arrayOfOpportunity.append(job)
                        } else {
                            for not in newOrderedTags {
                                if not.contains(tag) {
                                    arrayOfOpportunity.append(job)
                                }
                            }
                        }
                    }
                }
                delegate.jobsFiltered()
            }
        } catch let error as NSError {
            print("Error when try fetch all opportunities " + error.description)
        }
    }

    func markJobAsFavorite(_ job: Opportunity, completion: (_ success: String?) -> Void) {
        var exists = false
        let predicate = NSPredicate(format: "")
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
