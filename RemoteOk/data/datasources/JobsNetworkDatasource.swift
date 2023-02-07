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
    func getJobsOf(page: Int, completion: @escaping ((Result<DataJob, Error>)->Void))
    func searchJobsBy(query: String, completion: @escaping ((Result<DataJob, Error>)->Void))
}
