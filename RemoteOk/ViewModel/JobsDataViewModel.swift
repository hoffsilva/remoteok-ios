//
//  JobsDataViewModel.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 03/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol JobsDataDelegate: class {
    func loadJobDataSuccessful()
    func loadJobDataFailed(message: String)
}

struct JobsDataViewModel {
    
    weak var delegate: JobsDataDelegate!
    var jobsOpportunityViewModel = JobOportunityViewModel()
    
    func loadJobsFromRemoteOK() {
        self.jobsOpportunityViewModel.deleteAllOpportunities()
        Connection.fetchData { (arrayOfJobOportunities) in
            print((arrayOfJobOportunities as! Array<Any>).count)
            for job in arrayOfJobOportunities as! Array<Any>{
                let currentJob = JobOportunity()
                let jobDictionary = job as! [String:Any]
                currentJob.position = jobDictionary["position"] as? String
                currentJob.slug = jobDictionary["slug"] as? String
                currentJob.id = jobDictionary["id"] as? String
                currentJob.epoch = jobDictionary["epoch"] as? String
                currentJob.descriptionValue = jobDictionary["description"] as? String
                currentJob.date = jobDictionary["date"] as? String
                currentJob.logo = jobDictionary["logo"] as? String
                currentJob.tags = jobDictionary["tags"] as? [String]
                currentJob.company = jobDictionary["company"] as? String
                currentJob.url = jobDictionary["url"] as? String
                self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
            }
            self.delegate.loadJobDataSuccessful()
        }
    }
    
}
