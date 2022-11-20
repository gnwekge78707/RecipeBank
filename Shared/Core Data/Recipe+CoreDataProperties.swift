//
//  Recipe+CoreDataProperties.swift
//  Recipe-Builder
//
//  Created by youKnowWhoIAm on 24/10/2022.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var describe: String?
    @NSManaged public var instructions: [String]?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var amounts: [String]?
    @NSManaged public var comments: [String]?
    //@NSManaged public var ingreAmount: [(ingre: String, amout: String)]?
    @NSManaged public var image: Data?

}

extension Recipe : Identifiable {

}
