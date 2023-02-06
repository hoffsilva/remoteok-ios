//
//  JobsNetworkDatasource.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-05.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import Moya

protocol JobsNetworkDatasource {
    var provider: MoyaProvider<JobsProvider> { get set }
    func getJobsOf(page: Int, completion: @escaping ((Result<[JobOportunity], Error>)->Void))
    func searchJobsBy(query: String, in page: Int, completion: @escaping ((Result<[JobOportunity], Error>)->Void))
}
