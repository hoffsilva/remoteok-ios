//
//  FCMTokenRepository.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-16.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol FCMTokenRepository {
    func saveFCMToken(token: String, completion: @escaping ((Result<String, Error>)->Void))
}
