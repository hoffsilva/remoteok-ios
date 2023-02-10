//
//  GetAllJobsUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-06.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class GetAllJobsUseCaseImpl: GetAllJobsUseCase {
    
    let repository: JobsRepository
    var didGetJobs: ((DataJob) -> Void)?
    var didGetError: ((Error) -> Void)?
    
    init(repository: JobsRepository) {
        self.repository = repository
    }
    
    func getJobsOf(page: Int) {
        repository.getJobsOf(page: page) { [weak self] result in
            switch result {
            case .success(let dataJob):
                self?.didGetJobs?(dataJob)
            case .failure(let error):
                self?.didGetError?(error)
            }
        }
    }
    
}
