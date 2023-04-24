//
//  GetFavoritesJobsUseCase.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-23.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol GetFavoritesJobsUseCase {
    var didGetJobs: (([JobOportunity]) -> Void)? { get set }
    func getFavoriteJobs()
}
