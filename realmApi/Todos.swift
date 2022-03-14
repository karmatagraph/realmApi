//
//  Todos.swift
//  realmApi
//
//  Created by karma on 3/14/22.
//

import Foundation
import RealmSwift
class Todos: Object, Codable{
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var completed: Bool = false
    
}
