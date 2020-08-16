//
//  Flashcard+CoreDataProperties.swift
//  gizou-hin
//
//  Created by Angela Ng on 8/15/20.
//  Copyright © 2020 Angela Ng. All rights reserved.
//
//

import Foundation
import CoreData


extension Flashcard {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Flashcard> {
        return NSFetchRequest<Flashcard>(entityName: "Flashcard")
    }

    @NSManaged public var backText: String
    @NSManaged public var desc: String?
    @NSManaged public var frontText: String
    @NSManaged public var num: Int32
    @NSManaged public var inDeck: Deck

}
