//
//  Oportunity+CoreDataProperties.swift
//  
//
//  Created by Hoff Silva on 29/03/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Oportunity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Oportunity> {
        return NSFetchRequest<Oportunity>(entityName: "Oportunity")
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
    @NSManaged public var tags: NSObject?
    @NSManaged public var url: String?

}
