//
//  Opportunity+CoreDataProperties.swift
//  
//
//  Created by Hoff Henry Pereira da Silva on 29/03/2018.
//
//

import Foundation
import CoreData


extension Opportunity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Opportunity> {
        return NSFetchRequest<Opportunity>(entityName: "Opportunity")
    }

    @NSManaged public var company: String?
    @NSManaged public var date: String?
    @NSManaged public var desc: String?
    @NSManaged public var epoch: String?
    @NSManaged public var id: String?
    @NSManaged public var logo: String?
    @NSManaged public var position: String?
    @NSManaged public var slug: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var url: String?

}
