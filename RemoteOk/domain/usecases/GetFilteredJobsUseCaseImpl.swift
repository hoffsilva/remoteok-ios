//
//  GetFilteredJobsUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-07.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class GetFilteredJobsUseCaseImpl: GetFilteredJobsUseCase {
    
    let repository: JobsRepository
    var didGetJobs: (([JobOportunity]) -> Void)?
    var didGetError: ((Error) -> Void)?
    
    init(repository: JobsRepository) {
        self.repository = repository
    }
    
    func searchJobsBy(query: String) {
        repository.searchJobsBy(query: query) { [weak self] result in
            switch result {
            case .success(let dataOpportunity):
                self?.didGetJobs?(dataOpportunity.jobs)
            case .failure(let error):
                self?.didGetError?(error)
            }
        }
    }
    
}
