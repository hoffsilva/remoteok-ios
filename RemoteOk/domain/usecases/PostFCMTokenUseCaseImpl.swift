//
//  PostFCMTokenUseCaseImpl.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-16.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//
import Foundation

class PostFCMTokenUseCaseImpl: PostFCMTokenUseCase {
    
    let repository: FCMTokenRepository
    var didPostFCMToken: ((String) -> Void)?
    
    init(repository: FCMTokenRepository) {
        self.repository = repository
    }
    
    func saveFCMToken(token: String) {
        repository.saveFCMToken(token: token) { result in
            
        }
    }
    
}
