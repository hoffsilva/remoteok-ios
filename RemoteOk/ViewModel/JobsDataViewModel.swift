//
//  JobsDataViewModel.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 03/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Alamofire
import Foundation

protocol JobsDataDelegate: class {
    func loadJobDataSuccessful()
    func loadJobDataFailed(message: String)
}

struct JobsDataViewModel {
    weak var delegate: JobsDataDelegate!
    var jobsOpportunityViewModel = JobOportunityViewModel()
    
    func loadJobsFromAbroadJobsAPI() {
        self.jobsOpportunityViewModel.deleteAllOpportunities()
        Connection.fetchData(url: Constants.urlOfAllJobs) { arrayOfJobOportunities in
            self.parse(dic: arrayOfJobOportunities)
        }
    }
    
    func getJobsBy(parameter: [String]) {
        self.jobsOpportunityViewModel.filterJobsBy(tags: parameter)
    }
    
    func parse(dic: DataResponse<Any>) {
        guard let secureData = dic.data else { return }

        do {
            let arrayOfOppotunities = try JSONDecoder().decode([[JobOportunity]].self, from: secureData)
            for arrayOfJobs in arrayOfOppotunities {
                self.saveJobs(jobsList: arrayOfJobs)
            }
            self.delegate.loadJobDataSuccessful()
        } catch {
            self.delegate.loadJobDataFailed(message: Messages.errorParseDataJobs.description)
        }
    }
    
    func saveJobs(jobsList: [JobOportunity]) {
        for job in jobsList {
            self.jobsOpportunityViewModel.saveJobFromJSON(job)
        }
    }
}
