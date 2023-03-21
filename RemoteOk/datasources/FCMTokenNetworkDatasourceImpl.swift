//
//  FCMTokenNetworkDatasourceImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-16.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

final class FCMTokenNetworkDatasourceImpl: FCMTokenNetworkDatasource {
    
    var provider: Moya.MoyaProvider<FCMTokenProvider>
    
    init(provider: MoyaProvider<FCMTokenProvider>) {
        self.provider = provider
    }
    
    func saveFCMToken(token: Token, completion: @escaping ((Result<String, Error>) -> Void)) {
        provider.request(.saveFCMToken(token: token)) { result in
            self.parse(result: result, completion: completion)
        }
    }
    
    private func parse(result: Result<Moya.Response, MoyaError>, completion: @escaping ((Result<String, Error>) -> Void)) {
        switch result {
        case .success(let response):
            if response.statusCode == 200 {
                do {
                    let dataJob = try JSONDecoder().decode(DataJob.self, from: response.data)
                    completion(.success(""))
                } catch let error {
                    completion(.failure(FCMTokenNetworkDatasourceError.parseError(error.localizedDescription)))
                }
            } else {
                completion(
                    .failure(
                        FCMTokenNetworkDatasourceError
                            .serverError("")
                    )
                )
            }
        case .failure(let moyaError):
            completion(
                .failure(
                    FCMTokenNetworkDatasourceError
                        .requestError(moyaError.localizedDescription)
                )
            )
        }
    }
    
    enum FCMTokenNetworkDatasourceError: Error {
        var metadata: String { return String(describing: self) }
        case requestError(String)
        case parseError(String)
        case serverError(String)
    }
}
