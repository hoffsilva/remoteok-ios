//
//  GetFilteredJobsUseCase.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-06.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol GetFilteredJobsUseCase {
    var didGetJobs: (([JobOportunity]) -> Void)? { get set }
    var didGetError: ((Error) -> Void)? { get set }
    func searchJobsBy(query: String)
}
