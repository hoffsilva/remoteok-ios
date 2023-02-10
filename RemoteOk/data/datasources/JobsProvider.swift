//
//  JobsProvider.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-01-31.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya
import Alamofire

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
        case .searchJobsBy:
            return Constants.filteredJobsPath
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .searchJobsBy(let query, let page):
            return .requestParameters(parameters: ["query":query, "page":"\(page)"], encoding: QUERYEncoding.default)
        case .getJobsOf(let page):
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        nil
    }
    
}

struct QUERYEncoding: ParameterEncoding {
    static let `default` = QUERYEncoding()

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        
        guard let parameters = parameters as? [String:String] else { return request }
        
        let queryItems = parameters.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }

        var urlComponents = URLComponents()
        urlComponents.queryItems = queryItems
        
        guard let domainURL = request.url?.absoluteString else { return request }
        
        guard let componentsURL = urlComponents.url?.absoluteString else { return request }
        
        request.url = URL(string: domainURL + componentsURL)

        return request
    }
}
