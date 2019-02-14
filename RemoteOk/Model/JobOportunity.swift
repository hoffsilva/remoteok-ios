//
//  Oportunity.swift
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class JobOportunity: Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let jobTitle = "jobTitle"
        static let companyLogoURL = "companyLogoURL"
        static let companyName = "companyName"
        static let jobDescription = "jobDescription"
        static let applyURL = "applyURL"
        static let tags = "tags"
        static let source = "source"
    }
    
    // MARK: Properties
    public var jobTitle: String?
    public var companyLogoURL: String?
    public var companyName: String?
    public var jobDescription: String?
    public var applyURL: String?
    public var tags: [String]?
    public var source: String?
    
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    public init() {
        
    }
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        jobTitle = json[SerializationKeys.jobTitle].string
        companyLogoURL = json[SerializationKeys.companyLogoURL].string
        companyName = json[SerializationKeys.companyName].string
        jobDescription = json[SerializationKeys.jobDescription].string
        applyURL = json[SerializationKeys.applyURL].string
        if let items = json[SerializationKeys.tags].array { tags = items.map { $0.stringValue } }
        source = json[SerializationKeys.source].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = jobTitle { dictionary[SerializationKeys.jobTitle] = value }
        if let value = companyLogoURL { dictionary[SerializationKeys.companyLogoURL] = value }
        if let value = companyName { dictionary[SerializationKeys.companyName] = value }
        if let value = jobDescription { dictionary[SerializationKeys.jobDescription] = value }
        if let value = applyURL { dictionary[SerializationKeys.applyURL] = value }
        if let value = tags { dictionary[SerializationKeys.tags] = value }
        if let value = source { dictionary[SerializationKeys.source] = value }
        return dictionary
    }
    
}
