//
//  FCMTokenRepositoryImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-20.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class FCMTokenRepositoryImpl: FCMTokenRepository {
    
    private let datasource: FCMTokenNetworkDatasource
    
    init(datasource: FCMTokenNetworkDatasource) {
        self.datasource = datasource
    }
    
    func saveFCMToken(token: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        let token = Token(token: token, deviceOS: "iOS")
        datasource.saveFCMToken(token: token, completion: completion)
    }
    
}
