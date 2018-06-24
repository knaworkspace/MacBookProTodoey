//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Kaiden on 24/6/2018.
//  Copyright © 2018年 KNA Workshop. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var category = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request:NSFetchRequest<Category> = Category.fetchRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    //MARK: - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category[indexPath.row].name
        
        return cell
    }
    
    //MARK: - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = category[indexPath.row]
        }
        
    }
    
    //MARK: - Data manipulation methods
    
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("Error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
        do{
            category = try context.fetch(request)
        }catch{
            print("Error \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new category
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.category.append(newCategory)
            
            self.saveCategory()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "Create New Category"
            
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
