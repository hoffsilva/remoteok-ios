//
//  FavoriteJobsRepositoryImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-10.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class FavoriteJobsRepositoryImpl: FavoriteJobsRepository {
    
    private let datasource: FavoriteJobsDatasource
    
    init(datasource: FavoriteJobsDatasource) {
        self.datasource = datasource
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
