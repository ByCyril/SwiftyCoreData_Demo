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
    
    public var tableView: UITableView!
    private var navbar: UINavigationBar!
    
    private var cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarSetup()
        self.tableViewSetup()
        self.retrieveData()

    }
    
    // MARK: NavigationBar setup
    
    func navigationBarSetup() {
        
        let x: CGFloat = 0
        let y: CGFloat = 0
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = 44
        
        navbar = UINavigationBar(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view.addSubview(navbar)
        
        let navItem = UINavigationItem(title: "Container")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(ViewController.addDataView))
        navItem.rightBarButtonItem = addButton
        
        navbar.setItems([navItem], animated: true)
    }
    
    
    // MARK: TableView setup

    func tableViewSetup() {
        
        let x: CGFloat = 0
        let y: CGFloat = 0
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = 44
        
        tableView = UITableView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.view.addSubview(tableView)
        
    }
    
    // MARK: Display AlertController to add items

    @objc func addDataView() {
        
        let alertTitle = "Add Something"
        let cancelTitle = "Cancel"
        let saveTitle = "Save"
        let titleTextfieldPlaceholder = "Title"
        let detailsTextfieldPlaceholder = "Details"

        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = titleTextfieldPlaceholder
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = detailsTextfieldPlaceholder
        }
        
        let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        
        let saveButton = UIAlertAction(title: saveTitle, style: .default) { (save) in
            
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
        
        let objects = coredata[indexPath.row]
        let title = objects.value(forKey: "title") as! String
        let details = objects.value(forKey: "details") as! String
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = details
        
        return cell
    }
    
}

