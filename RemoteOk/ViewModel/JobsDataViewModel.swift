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
        if let dictionary = dic.result.value as? [[[String:Any]]] {
            print(dictionary.count)
            guard let remoteJobsArray = dictionary.first else {
                return
            }
            guard let landingJobsArray = dictionary.last else {
                return
            }
            for job in remoteJobsArray {
                let currentJob = JobOportunity(object: job)
                self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
            }
            
            for job in landingJobsArray {
                let currentJob = JobOportunity(object: job)
                self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
            }
            self.delegate.loadJobDataSuccessful()
        } else if let cryptoJobsDictionary = dic.result.value as? [[String:Any]] {
            for job in cryptoJobsDictionary {
                if (job["salaryRange"] != nil){
                    let currentCryptoJob = CryptoModel(dictionary: job as NSDictionary)
                    let currentJob = JobOportunity()
                    /*
                     static let position = "position"
                     static let slug = "slug"
                     static let id = "id"
                     static let epoch = "epoch"
                     static let descriptionValue = "description"
                     static let date = "date"
                     static let logo = "logo"
                     static let tags = "tags"
                     static let company = "company"
                     static let url = "url"
                     */
                    currentJob.jobTitle = currentCryptoJob?.jobTitle
                    currentJob.jobDescription = currentCryptoJob?.jobDescription
                    currentJob.companyLogoURL = currentCryptoJob?.companyLogo
                    currentJob.companyName = currentCryptoJob?.companyName
                    currentJob.applyURL = currentCryptoJob?.canonicalURL
                    self.jobsOpportunityViewModel.saveJobFromJSON(currentJob)
                }
            }
            
            self.delegate.loadJobDataSuccessful()
        }
        
    }
    
}
