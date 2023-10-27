//
//  Todo.swift
//  TodoRealm
//
//  Created by Alliston Aleixo on 21/10/23.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
    
   convenience init(name: String) {
       self.init()
       self.name = name
   }
}
