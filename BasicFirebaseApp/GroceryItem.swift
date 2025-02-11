//
//  GroceryItem.swift
//  BasicFirebaseApp
//
//  Created by EVANGELINE NOFTZ on 2/11/25.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class GroceryItem {
    var name: String
    var quantity: Int
    var ref = Database.database().reference()
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }

}
