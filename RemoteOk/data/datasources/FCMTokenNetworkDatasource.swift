//
//  FCMTokenNetworkDatasource.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-20.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

protocol FCMTokenNetworkDatasource {
    func saveFCMToken(token: String, completion: @escaping ((Result<String, Error>)->Void))
}
