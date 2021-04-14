//
//  BatasSuhu+CoreDataProperties.swift
//  LeleGroup
//
//  Created by Jason Hartanto on 12/04/21.
//
//

import Foundation
import CoreData


extension BatasSuhu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BatasSuhu> {
        return NSFetchRequest<BatasSuhu>(entityName: "BatasSuhu")
    }

    @NSManaged public var suhuKuningAtas: Double
    @NSManaged public var suhuKuningBawah: Double
    @NSManaged public var suhuKritisAtas: Double
    @NSManaged public var suhuKritisBawah: Double

}

extension BatasSuhu : Identifiable {

}
