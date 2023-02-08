//
//  OportunityFavorite+CoreDataProperties.swift
//  
//
//  Created by Hoff Henry Pereira da Silva on 30/03/2018.
//
//

import Foundation
import CoreData


extension OportunityFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OportunityFavorite> {
        return NSFetchRequest<OportunityFavorite>(entityName: "OpportunityFavorite")
    }

    @NSManaged public var company: String?
    @NSManaged public var date: String?
    @NSManaged public var desc: String?
    @NSManaged public var epoch: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var id: String?
    @NSManaged public var logo: String?
    @NSManaged public var position: String?
    @NSManaged public var slug: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var url: String?

}
