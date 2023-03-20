//
//  FCMTokenProvider.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-03-20.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum FCMTokenProvider {
    case saveFCMToken(token: String)
}

extension FCMTokenProvider: TargetType {
    var baseURL: URL {
        URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .saveFCMToken:
            return String(format: Constants.fcmtoken)
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case .saveFCMToken(let token):
            return .requestParameters(parameters: ["fcmtoken":token], encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
