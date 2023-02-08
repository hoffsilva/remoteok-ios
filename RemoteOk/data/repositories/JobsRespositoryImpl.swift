//
//  JobsRespositoryImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-06.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class JobsRespositoryImpl: JobsRepository {
    
    private let datasource: JobsNetworkDatasource
    
    init(datasource: JobsNetworkDatasource) {
        self.datasource = datasource
    }
    
    func getJobsOf(page: Int, completion: @escaping ((Result<DataJob, Error>) -> Void)) {
        datasource.getJobsOf(page: page, completion: completion)
    }
    
    func searchJobsBy(query: String, completion: @escaping ((Result<DataJob, Error>) -> Void)) {
        datasource.searchJobsBy(query: query, completion: completion)
    }
    
}
