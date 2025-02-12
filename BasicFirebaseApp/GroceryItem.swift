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
    var key = ""
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
    
    init(dict: [String: Any]) {
        // Safely unwrapping values from dictionary
        if let q = dict["quantity"] as? Int{
            quantity = q
        } else {
            quantity = 0
        }
        
        if let n = dict["name"] as? String{
            name = n
        } else {
            name = ""
        }

    }
    
    func saveToFirebase() {
        let dict = ["name": name, "quantity": quantity] as [String: Any]
        ref.child("groceries").childByAutoId().setValue(dict)
        key = ref.child("groceries").childByAutoId().key ?? "0"

    }
    
    func deleteFromFirebase() {
        ref.child("groceries").child(key).removeValue()
    }

}
