//
//  ViewController.swift
//  Todoey
//
//  Created by Calvin Tsang on 28/08/2019.
//  Copyright © 2019 Calvin Tsang. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Acquire Currency"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Disregard females"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Kick names and take ass"
        itemArray.append(newItem3)
        
        //        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
//            itemArray = items
//        }
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as UITableViewCell
        let currentItem = itemArray[indexPath.row]
        
        cell.textLabel?.text = currentItem.title
        
        // Ternary operator for cell.accessoryType
        cell.accessoryType = currentItem.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        // Reload the table view to update Item's done property by calling datasource methods again
        tableView.reloadData()
    }
    
    //MARK - Add Button Pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item To Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}

