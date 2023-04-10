//
//  Oportunity.swift
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation

struct JobOportunity: Codable, Identifiable, Hashable {
    let id = UUID()
    let identifier: Int
    let applyURL: String
    let companyLogoURL: String
    let companyName: String
    let jobDescription: String
    let jobTitle: String
    let sourceLogoURL: String
    let tags: String
    var isFavorite: Bool
}
