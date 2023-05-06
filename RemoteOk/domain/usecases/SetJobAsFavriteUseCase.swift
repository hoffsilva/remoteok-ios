//
//  SetJobAsFavriteUseCase.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-05-06.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol SetJobAsFavriteUseCase {
    var didSetJobAsFavorite: ((Bool) -> Void)? { get set }
    func setJobAsFavorite(job: JobOportunity)
}
