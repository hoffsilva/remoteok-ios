//
//  Oportunity.swift
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct JobOportunity: Codable {
    public var jobTitle: String?
    public var companyLogoURL: String?
    public var companyName: String?
    public var jobDescription: String?
    public var applyURL: String?
    public var tags: [String]?
    public var source: String?
    public var tagsStrings: String?
    
    enum CodingKeys: String, CodingKey {
        case jobTitle = "jobTitle"
        case companyLogoURL = "companyLogoURL"
        case companyName = "companyName"
        case jobDescription = "jobDescription"
        case applyURL = "applyURL"
        case tagsStrings = "tags"
        case source = "sourceLogoURL"
    }
}
