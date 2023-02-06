//
//  GetAllJobsUseCase.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-05.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol GetAllJobsUseCase {
    var jobsRepository: JobsRepository { get set }
}
