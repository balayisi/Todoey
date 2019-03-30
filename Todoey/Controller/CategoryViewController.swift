//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Melis Kaya on 29.03.2019.
//  Copyright © 2019 Melis Kaya. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [MyCategory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    //Mark: Tableview Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    

    
    //Mark: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //what will happen when the user clicks the Add Category button
            //Have access to our app delegate as an object
            let newCategory = MyCategory(context: self.context)
            
            newCategory.name = textField.text!
          
            self.categoryArray.append(newCategory)
        
            self.saveCategories()
            
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
            destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
        
        
        
    }
    
    //Mark: Data Manipulation Methods CRUD
    
    func saveCategories() {
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
        
    }
    
    
    func loadCategories(with request: NSFetchRequest<MyCategory> = MyCategory.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    
    
    
    
}
