//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Alexey Morozov on 15.03.2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension CachedFriend : Identifiable {
    public var wrappedName: String {
        name ?? ""
    }
}
