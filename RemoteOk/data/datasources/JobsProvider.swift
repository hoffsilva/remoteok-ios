//
//  JobsProvider.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-01-31.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

enum JobsProvider {
    case getJobsOf(page:Int)
    case searchJobsBy(query:String, page:Int)
}

extension JobsProvider: TargetType {
    var baseURL: URL {
        URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getJobsOf(let page):
            return String(format: Constants.jobsPath, "\(page)")
        case .searchJobsBy(let query, let page):
            return String(format: Constants.filteredJobsPath, query, "\(page)")
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
