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
    var provider: Moya.MoyaProvider<JobsProvider>
    
    init(provider: MoyaProvider<JobsProvider>) {
        self.provider = provider
    }
    
    func getJobsOf(page: Int, completion: @escaping ((Result<DataJob, Error>) -> Void)) {
        provider.request(.getJobsOf(page: page)) { result in
            self.parse(result: result, completion: completion)
        }
    }
    
    func searchJobsBy(query: String, completion: @escaping ((Result<DataJob, Error>) -> Void)) {
        provider.request(.searchJobsBy(query: query, page: 1)) { result in
            self.parse(result: result, completion: completion)
        }
    }
    
    private func parse(result: Result<Moya.Response, MoyaError>, completion: @escaping ((Result<DataJob, Error>) -> Void)) {
        switch result {
        case .success(let response):
            if response.statusCode == 200 {
                do {
                    let dataJob = try JSONDecoder().decode(DataJob.self, from: response.data)
                    completion(.success(dataJob))
                } catch let error {
                    completion(.failure(JobsNetworkDatasourceError.parseError(error.localizedDescription)))
                }
            } else {
                completion(
                    .failure(
                        JobsNetworkDatasourceError
                            .serverError("")
                    )
                )
            }
        case .failure(let moyaError):
            completion(
                .failure(
                    JobsNetworkDatasourceError
                        .requestError(moyaError.localizedDescription)
                )
            )
        }
    }
    
    enum JobsNetworkDatasourceError: Error {
        var metadata: String { return String(describing: self) }
        case requestError(String)
        case parseError(String)
        case serverError(String)
    }
}
