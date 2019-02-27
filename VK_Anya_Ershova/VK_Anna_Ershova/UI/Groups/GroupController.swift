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
import RealmSwift

class GroupController: UITableViewController {
    
    
    //var groups = ["Barbie", "Bratz", "Myscene", "Monsterhigh"]
    //private var imagesGr = ["Barbie", "Bratz", "Myscene", "Monsterhigh"]
    
    var groupsVK = Array<Group>()
    var groupService = VKService()
    var groupname = [String]()
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.tableView.reloadData()
//    }
    override func viewWillAppear(_ animated: Bool) {
        groupService.loadGroups(){ [weak self] groupsVK, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groupsVK = groupsVK, let self = self {
                self.groupsVK = groupsVK
                
                //RealmProvider.save(items: groupsVK)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.reloadData()
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        groupsVK = Array(realm.objects(Group.self))
    }
//    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
//        self.tableView.reloadData()
//        return true
//    }
//
    
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
        return groupsVK.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        
        cell.configured(with: groupsVK[indexPath.row])
        
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            groupsVK.remove(at: indexPath.row)
    //            //groupService.leftGroups(for: groupsVK[indexPath.row].id)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //            tableView.reloadData()
    //        }
    //    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let ownerGroup = self.groupsVK[indexPath.row]
        let delAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            print("Del Action Tapped")
            self.groupsVK.remove(at: indexPath.row)
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(ownerGroup)
                try realm.commitWrite()
            } catch {
                print(error)
            }
            tableView.reloadData()
            
        }
        delAction.backgroundColor = .red
        self.groupService.leftGroups(for: ownerGroup.id)
        self.tableView.reloadData()
        return [delAction]
    }
    
//        @IBAction func add(segue: UIStoryboardSegue) {
//            if segue.identifier == "add" {
//    
//                let allGroupController = segue.source as! AllGroupController
//                if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
//                    let gr = allGroupController.allgroupsVK[indexPath.row]
//                    if  groupsVK[indexPath.row].name.contains(gr.name) {
//                        groupsVK.append(allGroupController.filterGr[indexPath.row])
//                        tableView.reloadData()
//                    } else {
//                        print("error")
//                    }
//                }
//            }
//        }
    
    
    
}
