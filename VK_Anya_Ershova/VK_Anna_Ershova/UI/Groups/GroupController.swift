//
//  GroupController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 28/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit

class GroupController: UITableViewController{
    
    
    var groups = ["Barbie", "Bratz", "Myscene", "Monsterhigh"]
    //private var imagesGr = ["Barbie", "Bratz", "Myscene", "Monsterhigh"]
    
    
    
    @IBAction func add(segue: UIStoryboardSegue) {
        if segue.identifier == "add" {
            
            let allGroupController = segue.source as! AllGroupController
            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
                
                let gr = allGroupController.filterGr[indexPath.row]
                //let grAll = allGroupController.groupsAll[indexPath.row]
                if !groups.contains(gr) {
                    groups.append(gr)
                    tableView.reloadData()
                }
                
            }
            
        }
        
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
    
        let group = groups[indexPath.row]
        let img = UIImage(named: group)
        cell.configure(friend: group, img: img!)


        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            groups.remove(at: indexPath.row)
            //imagesGr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }



}
