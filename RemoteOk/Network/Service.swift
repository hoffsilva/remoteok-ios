//
//  Service.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-01-31.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol Service {
    func getJobsOf(page: Int, completion: @escaping ((Result<[JobOportunity], Error>)->Void))
}
