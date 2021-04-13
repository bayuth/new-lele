//
//  Kolam+CoreDataProperties.swift
//  LeleGroup
//
//  Created by Jason Hartanto on 13/04/21.
//
//

import Foundation
import CoreData


extension Kolam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kolam> {
        return NSFetchRequest<Kolam>(entityName: "Kolam")
    }

    @NSManaged public var id: Int64
    @NSManaged public var nama: String?
    @NSManaged public var pengguna: Pengguna?
    @NSManaged public var peringatan: NSSet?

}

// MARK: Generated accessors for peringatan
extension Kolam {

    @objc(addPeringatanObject:)
    @NSManaged public func addToPeringatan(_ value: Peringatan)

    @objc(removePeringatanObject:)
    @NSManaged public func removeFromPeringatan(_ value: Peringatan)

    @objc(addPeringatan:)
    @NSManaged public func addToPeringatan(_ values: NSSet)

    @objc(removePeringatan:)
    @NSManaged public func removeFromPeringatan(_ values: NSSet)

}

extension Kolam : Identifiable {

}
