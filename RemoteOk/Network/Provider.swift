//
//  Provider.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-01-31.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

enum Provider {
    case getJobsOf(page:Int)
}

extension Provider: TargetType {
    var baseURL: URL {
        URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getJobsOf(let page):
            return Constants.jobsPath + "\(page)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}
