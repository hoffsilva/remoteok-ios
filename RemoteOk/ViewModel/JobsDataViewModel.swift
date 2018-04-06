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
            let dic = arrayOfJobOportunities.result.value as! [[String:Any]]
            print(dic.count)
            for job in dic {
                let currentJob = JobOportunity(object: job)
                self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
            }
            self.delegate.loadJobDataSuccessful()
        }
    }
    
}
