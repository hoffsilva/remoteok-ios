//
//  DataJob.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-06.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

class DataJob: Decodable {
    let jobs: [JobOportunity]
    let numberOfPages: Int
    
    enum CodingKeys: String, CodingKey {
        case jobs = "data"
        case numberOfPages
    }
}
