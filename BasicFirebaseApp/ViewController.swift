//
//  ViewController.swift
//  BasicFirebaseApp
//
//  Created by EVANGELINE NOFTZ on 2/11/25.
//

import UIKit
import FirebaseCore
import FirebaseDatabase


class ViewController: UIViewController {
    
    @IBOutlet weak var groceryTableView: UITableView!
    
    @IBOutlet weak var groceryItemInput: UITextField!
    
    @IBOutlet weak var groceryQuantityInput: UITextField!
    
    
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
    }
    
    
    @IBAction func addItemAction(_ sender: UIButton) {
        var item = GroceryItem(name: groceryItemInput.text!, quantity: Int(groceryQuantityInput.text!)!)
        
        //ref.child("groceries").childByAutoId().setValue(name)
    }
    


}

