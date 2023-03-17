//
//  PostFCMTokenUseCase.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-16.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol PostFCMTokenUseCase {
    var didPostFCMToken: ((String) -> Void)? { get set }
    func saveFCMToken(token: String)
}
