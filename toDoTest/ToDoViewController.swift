//
//  ViewController.swift
//  toDoTest
//
//  Created by AHMED GAMAL  on 21/05/2023.
//

import UIKit

class ToDoViewController: UITableViewController {

    var itemArray : [String] = ["save movie", "read book", "take lunch"]
    let addingText : UITextField
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
    
    
    
    
    
}

