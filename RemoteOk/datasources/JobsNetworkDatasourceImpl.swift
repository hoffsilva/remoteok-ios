//
//  ServiceImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-01-31.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

final class JobsNetworkDatasourceImpl: JobsNetworkDatasource {
    
    private let provider: MoyaProvider<Provider>
    
    init(provider: MoyaProvider<Provider>) {
        self.provider = provider
    }
    
    func getJobsOf(page: Int, completion: @escaping ((Result<[JobOportunity], Error>)->Void))  {
        provider.request(.getJobsOf(page: page)) { result in
            print("asa")
    
        }
    }
    
    func searchJobsBy(query: String, in page: Int, completion: @escaping ((Result<[JobOportunity], Error>) -> Void)) {
        provider .request(.searchJobsBy(query: query, page: page)) { result in
            
        }
    }
    
    
    
}
