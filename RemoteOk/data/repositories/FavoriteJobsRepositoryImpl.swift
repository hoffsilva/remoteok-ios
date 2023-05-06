//
//  FavoriteJobsRepositoryImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-10.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class FavoriteJobsRepositoryImpl: FavoriteJobsRepository {
    
    private var datasource: FavoriteJobsDatasource
    
    var didSaveJobWithSuccess: ((String) -> Void)?
    var didSaveJobWithError: ((String) -> Void)?
    var didDeleteJobWithSuccess: ((String) -> Void)?
    var didDeletsJobWithError: ((String) -> Void)?
    
    init(datasource: FavoriteJobsDatasource) {
        self.datasource = datasource
        setupBindings()
    }
    
    private func setupBindings() {
        datasource.didDeleteJobWithSuccess = { [weak self] message in
            self?.didSaveJobWithSuccess?(message)
        }
        
        datasource.didDeletsJobWithError = { [weak self] message in
            self?.didDeletsJobWithError?(message)
        }
        
        datasource.didSaveJobWithError = { [weak self] message in
            self?.didSaveJobWithError?(message)
        }
        
        datasource.didSaveJobWithSuccess = { [weak self] message in
            self?.didSaveJobWithSuccess?(message)
        }
    }
    
    func getJobs(completion: @escaping (([JobOportunity]) -> Void)) {
        datasource.getJobs(completion: completion)
    }
    
    func saveJob(jobOportunity: JobOportunity) {
        datasource.saveJob(jobOportunity: jobOportunity)
    }
    
    func deleteJob(id: Int) {
        datasource.deleteJob(id: id)
    }
    
}
