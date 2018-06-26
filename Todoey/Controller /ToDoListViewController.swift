//
//  ViewController.swift
//  Todoey
//
//  Created by Kaiden on 23/6/2018.
//  Copyright © 2018年 KNA Workshop. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    let realm = try! Realm()
    
    var toDoItems:Results<Item>?
    var selectedCategory:Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK: - Tableview datasource methode
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            //setup the checkmark show/hidden by using Ternary operator
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Item Add"
        }
        
        return cell
        
    }
    
    //MARK: - Tableview delegate methode
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
//
//        saveItem()
        if let item = toDoItems?[indexPath.row] {
            do{
                try realm.write {
                item.done = !item.done
            }
            }catch{
                print("Error saving status \(error)")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //MARK: - Add new item
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what happen once when tap add btn
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error save \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manupopulation method
    
    
    func loadItems(){
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
}


//MARK: - Search bar method

    extension ToDoListViewController:UISearchBarDelegate{
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
            toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            tableView.reloadData()
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0{
                loadItems()
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
    }







