//
//  Pengguna+CoreDataProperties.swift
//  LeleGroup
//
//  Created by Jason Hartanto on 13/04/21.
//
//

import Foundation
import CoreData


extension Pengguna {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pengguna> {
        return NSFetchRequest<Pengguna>(entityName: "Pengguna")
    }

    @NSManaged public var nama: String?
    @NSManaged public var password: String?
    @NSManaged public var jumlahKolam: Int64
    @NSManaged public var kolam: NSSet?

}

// MARK: Generated accessors for kolam
extension Pengguna {

    @objc(addKolamObject:)
    @NSManaged public func addToKolam(_ value: Kolam)

    @objc(removeKolamObject:)
    @NSManaged public func removeFromKolam(_ value: Kolam)

    @objc(addKolam:)
    @NSManaged public func addToKolam(_ values: NSSet)

    @objc(removeKolam:)
    @NSManaged public func removeFromKolam(_ values: NSSet)

}

extension Pengguna : Identifiable {

}
