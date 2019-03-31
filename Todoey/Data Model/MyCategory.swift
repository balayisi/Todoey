//
//  MyCategory.swift
//  Todoey
//
//  Created by Melis Kaya on 30.03.2019.
//  Copyright © 2019 Melis Kaya. All rights reserved.
//

import Foundation
import RealmSwift

class MyCategory: Object {
    @objc dynamic var name: String = ""
    //forward relationship
    let items = List<Item>()
}
