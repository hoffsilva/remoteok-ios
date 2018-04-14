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
        static let position = "position"
        static let slug = "slug"
        static let id = "id"
        static let epoch = "epoch"
        static let descriptionValue = "description"
        static let date = "date"
        static let logo = "logo"
        static let tags = "tags"
        static let company = "company"
        static let url = "url"
    }
    
    // MARK: Properties
    public var position: String?
    public var slug: String?
    public var id: String?
    public var epoch: String?
    public var descriptionValue: String?
    public var date: String?
    public var logo: String?
    public var tags: [String]?
    public var company: String?
    public var url: String?
    
    public convenience init(object: Any) {
        self.init(json: JSON(object))
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
        position = json[SerializationKeys.position].string
        slug = json[SerializationKeys.slug].string
        id = json[SerializationKeys.id].string
        epoch = json[SerializationKeys.epoch].string
        descriptionValue = json[SerializationKeys.descriptionValue].string
        date = json[SerializationKeys.date].string
        logo = json[SerializationKeys.logo].string
        if let items = json[SerializationKeys.tags].array { tags = items.map { $0.stringValue } }
        company = json[SerializationKeys.company].string
        url = json[SerializationKeys.url].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = position { dictionary[SerializationKeys.position] = value }
        if let value = slug { dictionary[SerializationKeys.slug] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = epoch { dictionary[SerializationKeys.epoch] = value }
        if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
        if let value = date { dictionary[SerializationKeys.date] = value }
        if let value = logo { dictionary[SerializationKeys.logo] = value }
        if let value = tags { dictionary[SerializationKeys.tags] = value }
        if let value = company { dictionary[SerializationKeys.company] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        return dictionary
    }
    
}
