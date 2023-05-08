//
//  DeleteJobFromFavoritesUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-05-07.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

final class DeleteJobFromFavoritesUseCaseImpl: DeleteJobFromFavoritesUseCase {
    var didDeleteJobFromFavorites: ((Bool) -> Void)?
    
    private var repository: FavoriteJobsRepository
    
    init(repository: FavoriteJobsRepository) {
        self.repository = repository
        setupBindings()
    }
    
    private func setupBindings() {
        repository.didSaveJobWithError = { [weak self] message in
            self?.didDeleteJobFromFavorites?(false)
        }
        
        repository.didSaveJobWithSuccess = { [weak self] message in
            self?.didDeleteJobFromFavorites?(true)
        }
    }
    
    func deleteJobFromFavorites(job: JobOportunity) {
        repository.deleteJob(id: job.identifier)
    }
    
    
}
