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

    @NSManaged public var suhuKuningAtas: Int64
    @NSManaged public var suhuKuningBawah: Int64
    @NSManaged public var suhuKritisAtas: Int64
    @NSManaged public var suhuKritisBawah: Int64

}

extension BatasSuhu : Identifiable {

}
