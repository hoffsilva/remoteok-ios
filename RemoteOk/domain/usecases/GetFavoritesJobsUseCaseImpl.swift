//
//  GetFavoritesJobsUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-23.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class GetFavoritesJobsUseCaseImpl: GetFavoritesJobsUseCase {
    
    var didGetJobs: (([JobOportunity]) -> Void)?
    
    private let repository: FavoriteJobsRepository
    
    init(repository: FavoriteJobsRepository) {
        self.repository = repository
    }
    
    func getFavoriteJobs() {
        repository.getJobs { [weak self] favoriteJobs in
            self?.didGetJobs?(favoriteJobs)
        }
    }
    
}
