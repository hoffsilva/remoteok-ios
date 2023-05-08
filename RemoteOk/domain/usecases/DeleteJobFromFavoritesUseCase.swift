//
//  DeleteJobFromFavoritesUseCase.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-05-07.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol DeleteJobFromFavoritesUseCase {
    var didDeleteJobFromFavorites: ((Bool) -> Void)? { get set }
    func deleteJobFromFavorites(job: JobOportunity)
}
