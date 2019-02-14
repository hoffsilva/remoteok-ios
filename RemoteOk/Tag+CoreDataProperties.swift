//
//  Tag+CoreDataProperties.swift
//  
//
//  Created by Hoff Silva on 13/04/2018.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var isSelected: Bool?

}
