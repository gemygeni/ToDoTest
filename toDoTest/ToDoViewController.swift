//
//  ViewController.swift
//  toDoTest
//
//  Created by AHMED GAMAL  on 21/05/2023.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray : [Item] = []
    let defaults = UserDefaults.standard
    
    let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: "items")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    // tableview dataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell" , for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        return cell
    }
    
    //tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
     }
    
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var addingTextField = UITextField()
        let alert = UIAlertController(title: "add new Item", message: "", preferredStyle: .alert)
      
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            let newItem = Item(title: addingTextField.text ?? "new Item")
            self.itemArray.append(newItem)
            self.saveData()
        }
        
        alert.addTextField { textField in
            textField.placeholder = "add new item"
            addingTextField = textField
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    func saveData(){
        
        
        let encoder = JSONEncoder()
        do {
            let data =  try encoder.encode(self.itemArray)
            try data.write(to: fileDirectory)
        }catch{
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
    
    func loadData(){
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileDirectory)
            itemArray = try decoder.decode([Item].self, from: data)
        }catch {
            print(error.localizedDescription)
            
        }
       

    }
}

