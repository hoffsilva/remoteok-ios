//
//  SetJobAsFavriteUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-05-06.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class SetJobAsFavriteUseCaseImpl: SetJobAsFavriteUseCase {
    
    var didSetJobAsFavorite: ((Bool) -> Void)?
    
    private var repository: FavoriteJobsRepository
    
    init(repository: FavoriteJobsRepository) {
        self.repository = repository
        setupBindings()
    }
    
    private func setupBindings() {
        repository.didSaveJobWithError = { [weak self] message in
            self?.didSetJobAsFavorite?(false)
        }
        
        repository.didSaveJobWithSuccess = { [weak self] message in
            self?.didSetJobAsFavorite?(true)
        }
    }
    
    func setJobAsFavorite(job: JobOportunity) {
        repository.saveJob(jobOportunity: job)
    }
    
}
