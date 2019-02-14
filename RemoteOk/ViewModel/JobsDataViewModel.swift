//
//  JobsDataViewModel.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 03/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Alamofire

protocol JobsDataDelegate: class {
    func loadJobDataSuccessful()
    func loadJobDataFailed(message: String)
}

struct JobsDataViewModel {
    
    
    weak var delegate: JobsDataDelegate!
    var jobsOpportunityViewModel = JobOportunityViewModel()
    
    func loadJobsFromRemoteOK(_ URL: String) {
        self.jobsOpportunityViewModel.deleteAllOpportunities()
        Connection.fetchData(url: URL) { (arrayOfJobOportunities) in
            self.parse(dic: arrayOfJobOportunities)
        }
    }
    
    func getJobsBy(parameter: [String]) {
        self.jobsOpportunityViewModel.filterJobsBy(tags: parameter)
    }
    
    func parse(dic: DataResponse<Any>) {
        
        if let dictionary = dic.result.value as? [[[String:Any]]] {
            print(dictionary.count)
            saveJobs(jobsList: dictionary[0])
            saveJobs(jobsList: dictionary[1])
            saveJobs(jobsList: dictionary[2])
            self.delegate.loadJobDataSuccessful()
        }else {
            self.delegate.loadJobDataFailed(message: "Loading jobs data error.")
        }
    }
    
    func saveJobs(jobsList: [[String:Any]]) {
        for job in jobsList {
            let currentJob = JobOportunity(object: job)
            self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
        }
    }
    
}
