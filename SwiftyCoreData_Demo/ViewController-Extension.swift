//
//  ViewController-Extension.swift
//  SwiftyCoreData_Demo
//
//  Created by Cyril Garcia on 11/20/17.
//  Copyright © 2017 ByCyril. All rights reserved.
//

import UIKit

extension ViewController {
    
    public func addData(title: String, details: String) {
        module.push(values: [title, details], keys: ["title", "details"])
    }
    
    public func removeData(index: Int, indexPath: IndexPath, tableViewAnimation: UITableViewRowAnimation ) {
        module.remove(object: coredata, index: index)
        coredata.remove(at: index)
        tableView.deleteRows(at: [indexPath], with: tableViewAnimation)
    }
    
    public func retrieveData() {
        coredata = module.retrieveData()
    }
    

}
