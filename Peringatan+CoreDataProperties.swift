//
//  Peringatan+CoreDataProperties.swift
//  LeleGroup
//
//  Created by Jason Hartanto on 13/04/21.
//
//

import Foundation
import CoreData


extension Peringatan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Peringatan> {
        return NSFetchRequest<Peringatan>(entityName: "Peringatan")
    }

    @NSManaged public var id: Int64
    @NSManaged public var temperature: Float
    @NSManaged public var status: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var kolam: Kolam?

}

extension Peringatan : Identifiable {

}
