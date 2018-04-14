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
    
    func parse(dic: DataResponse<Any>) {
        if let dictionary = dic.result.value as? [[String:Any]] {
            print(dictionary.count)
            for job in dictionary {
                let currentJob = JobOportunity(object: job)
                self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
            }
            self.delegate.loadJobDataSuccessful()
        }
        
    }
    
}
