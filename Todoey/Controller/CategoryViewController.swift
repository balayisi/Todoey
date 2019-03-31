//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Melis Kaya on 29.03.2019.
//  Copyright © 2019 Melis Kaya. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    //var categoryArray = [MyCategory]()
    var categoryArray: Results<MyCategory>?
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    //Mark: Tableview Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? nil
        
        return cell
    }
    
    

    
    //Mark: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //what will happen when the user clicks the Add Category button
            //Have access to our app delegate as an object
            let newCategory = MyCategory()
            
            newCategory.name = textField.text!
        
            self.save(category: newCategory)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            print(alertTextField)
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    
    //Mark: Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if you have more than one use if statement with identifier
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
            
        }
        
        
        
    }
    
    //Mark: Data Manipulation Methods CRUD
    
    func save(category: MyCategory) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
        
    }
    

    
    func loadCategories() {
        categoryArray = realm.objects(MyCategory.self)
        
        tableView.reloadData()
    }
    
    
    
    
    
    
    
}
