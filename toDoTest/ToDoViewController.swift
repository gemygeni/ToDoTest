//
//  ViewController.swift
//  toDoTest
//
//  Created by AHMED GAMAL  on 21/05/2023.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray : [String] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let  dataArray = defaults.array(forKey: "itemArray") as? [String]{
            itemArray = dataArray
        }
    }
    // tableview dataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell" , for: indexPath)
            cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
     }
    
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var addingTextField = UITextField()
        let alert = UIAlertController(title: "add new Item", message: "", preferredStyle: .alert)
      
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            self.itemArray.append(addingTextField.text ?? "new Item")
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
        self.defaults.set(self.itemArray, forKey: "itemArray")
        self.tableView.reloadData()
    }
    
    
}

