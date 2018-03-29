//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class JobOportunityViewModel {
    
    
    var arrayOfJobs = [JobOportunity]()
    
    func loadJobs() {
        Connection.fetchData { (arrayOfJobOportunities) in
            
        }
    }
    
    func persistJob(job: JobOportunity) {
        
    }
    
}
