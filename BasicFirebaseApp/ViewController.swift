//
//  ViewController.swift
//  BasicFirebaseApp
//
//  Created by EVANGELINE NOFTZ on 2/11/25.
//

import UIKit
import FirebaseCore
import FirebaseDatabase


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groceryTableView: UITableView!
    
    @IBOutlet weak var groceryItemInput: UITextField!
    
    @IBOutlet weak var groceryQuantityInput: UITextField!
    
    var ref: DatabaseReference!
    
    var groceries = [GroceryItem]()
    
    var selectedRow = -1
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        groceryTableView.delegate = self
        groceryTableView.dataSource = self

        
        ref = Database.database().reference()
        
        readFromFirebase()
        
    }
    
    
    func readFromFirebase() {
        // object
        ref.child("groceries").observe(.childAdded, with: { (snapshot) in
            // snapshot is a dictionary with a key and a dictionary as a value
            // this gets the dictionary from each snapshot
            let dict = snapshot.value as! [String:Any]
                   
            // building a Student object from the dictionary
            let s = GroceryItem(dict: dict)
            
            s.key = snapshot.key

            // adding the student object to the Student array
            
            var yes = 0
            for g in self.groceries {
                if g.name == s.name && g.quantity == s.quantity {
                    yes = 1
                }
            }
            if yes == 0 {
                self.groceries.append(s)
            }
            
            self.groceryTableView.reloadData()
            // should only add the student if the student isn’t already in the array
            // good place to update the tableview also
                    
        })
        
        
        
        // finding deleted objects
        ref.child("groceries").observe(.childRemoved, with: { (snapshot) in
            
            for i in 0...self.groceries.count - 1 {
                print("\(self.groceries[i].name)")
                if snapshot.key == self.groceries[i].key {
                    self.groceries.remove(at: i)
                    break
                }
            }
            self.groceryTableView.reloadData()
                    
        })
                

    }
    
    
    
    
    @IBAction func addItemAction(_ sender: UIButton) {
        var item = GroceryItem(name: groceryItemInput.text!, quantity: Int(groceryQuantityInput.text!)!)
        
        //ref.child("groceries").childByAutoId().setValue(name)
        
        
        
        item.saveToFirebase()
        
        //ref.child("students2").childByAutoId().setValue(student)
        groceries.append(item)
                
        groceryTableView.reloadData()
        
        groceryItemInput.text = ""
        groceryQuantityInput.text = ""
    }
    
    
    @IBAction func changeItemAction(_ sender: UIButton) {
        groceries[selectedRow].name = groceryItemInput.text!
        groceries[selectedRow].quantity = Int(groceryQuantityInput.text!)!
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return names.count
        return groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! GroceryCell
        //cell.nameLabel.text = "\(names[indexPath.row])"
        
       
        
        cell.itemLabel.text = "\(groceries[indexPath.row].name)"
        cell.quantityLabel.text = "\(groceries[indexPath.row].quantity)"
        
        //index = indexPath.row
        
        return cell
    }
    
    // swipe to delete on table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groceries[indexPath.row].deleteFromFirebase()
            groceries.remove(at: indexPath.row)
            groceryTableView.deleteRows(at: [indexPath], with: .fade)
            groceryTableView.reloadData()
        } else if editingStyle == .insert {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    // LEFT OFF: 10f
    


}

