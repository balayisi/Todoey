//
//  Item.swift
//  Todoey
//
//  Created by Melis Kaya on 30.03.2019.
//  Copyright © 2019 Melis Kaya. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    //reverse relationship
    var parentCategory = LinkingObjects(fromType: MyCategory.self, property: "items")
    
}
