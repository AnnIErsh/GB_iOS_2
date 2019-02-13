//
//  GroupController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 28/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class GroupController: UITableViewController{
    
    
    //var groups = ["Barbie", "Bratz", "Myscene", "Monsterhigh"]
    //private var imagesGr = ["Barbie", "Bratz", "Myscene", "Monsterhigh"]
    
    var groupsVK = [Group]()
    var groupService = VKService()
    var groupname = [String]()
    
//    @IBAction func add(segue: UIStoryboardSegue) {
//        if segue.identifier == "add" {
//
//            let allGroupController = segue.source as! AllGroupController
//            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
//
//                let gr = allGroupController.filterGr[indexPath.row]
//                //let grAll = allGroupController.groupsAll[indexPath.row]
//                if !groupsVK.contains(where: gr) {
//                    groupsVK.append(gr)
//                    tableView.reloadData()
//                }
//
//            }
//
//        }
//
//    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupService.loadGroups(){ [weak self] groupsVK, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groupsVK = groupsVK, let self = self {
                self.groupsVK = groupsVK
        
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsVK.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
    
//        let group = groups[indexPath.row]
//        let img = UIImage(named: group)
//        cell.configure(friend: group, img: img!)
        cell.configured(with: groupsVK[indexPath.row])


        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsVK.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }



}
