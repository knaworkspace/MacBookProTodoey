//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Kaiden on 24/6/2018.
//  Copyright © 2018年 KNA Workshop. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories:Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    //MARK: - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Add"
        
        return cell
    }
    
    //MARK: - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    //MARK: - Data manipulation methods
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Add new category
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
  
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Create New Category"
            
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
