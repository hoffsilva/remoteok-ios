//
//  GetFilteredJobsUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-07.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class GetFilteredJobsUseCaseImpl: GetFilteredJobsUseCase {
    
    var didGetJobs: (([JobOportunity]) -> Void)?
    
    var didGetError: ((Error) -> Void)?
    
    func searchJobsBy(query: String) {
        
    }
    
}
