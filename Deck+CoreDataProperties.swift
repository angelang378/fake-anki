//
//  Deck+CoreDataProperties.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/29/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var name: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var hasCards: NSSet?

}

// MARK: Generated accessors for hasCards
extension Deck {

    @objc(addHasCardsObject:)
    @NSManaged public func addToHasCards(_ value: Flashcard)

    @objc(removeHasCardsObject:)
    @NSManaged public func removeFromHasCards(_ value: Flashcard)

    @objc(addHasCards:)
    @NSManaged public func addToHasCards(_ values: NSSet)

    @objc(removeHasCards:)
    @NSManaged public func removeFromHasCards(_ values: NSSet)

}
