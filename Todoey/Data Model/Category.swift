//
//  Category.swift
//  Todoey
//
//  Created by Kaiden on 24/6/2018.
//  Copyright © 2018年 KNA Workshop. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
    
}
