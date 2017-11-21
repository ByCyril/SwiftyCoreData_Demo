//
//  ViewController.swift
//  SwiftyCoreData_Demo
//
//  Created by Cyril Garcia on 11/19/17.
//  Copyright © 2017 ByCyril. All rights reserved.
//

import UIKit
import CoreData
import SwiftyCoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var module = CoreDataModule(entityName: "SavedData", xcDataModelID: "SwiftyCoreData_Demo")
    
    public var coredata = [NSManagedObject]()
    
    public var tableView = UITableView()
    private var cellIdentifier = "Cell"
    private var addButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableViewSetup()
        self.retrieveData()
    }
    
    
    @IBAction func addDataView() {
        let alert = UIAlertController(title: "Add Something", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Title"
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Details"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (save) in
            
            let title = alert.textFields![0].text!
            let details = alert.textFields![1].text!
            
            self.addData(title: title, details: details)
            
            self.retrieveData()
            self.tableView.reloadData()
        }
        
        alert.addAction(cancelButton)
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableViewSetup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = self.view.frame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            removeData(index: indexPath.row, indexPath: indexPath, tableViewAnimation: .fade)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coredata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        let title = coredata[indexPath.row].value(forKey: "title") as! String
        let details = coredata[indexPath.row].value(forKey: "details") as! String
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = details
        
        return cell
    }
    
}

