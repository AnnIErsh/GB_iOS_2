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
import Firebase
import FirebaseDatabase

class GroupController: UITableViewController {
    
    var notificationToken: NotificationToken?
    let realmProvider = RealmProvider()
    
//    private static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    
    var groupsVK: Results<Group>?
//    var groupsVK: Results<Group> = {
//        let groupObject = realm.objects(Group.self)
//        return groupObject
//    }()
    var groupService = VKService()
    var groupname = [String]()
    
    private var firebaseVK = [FirebaseVK]()
    private let ref = Database.database().reference(withPath: "users")
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.tableView.reloadData()
    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
//    }
    override func viewWillAppear(_ animated: Bool) {
        //pairTableAndRealm()
        groupService.loadGroups()
        
        //pairTableAndRealm()
        self.tableView.reloadData()
    }
    
//    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
//        self.tableView.reloadData()
//        return true
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pairTableAndRealm()
       
        
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsVK?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell,
            let mygroup = groupsVK?[indexPath.row] else { return UITableViewCell() }
        cell.configured(with: mygroup)
        
        return cell
    }
    
    
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            guard let mygroup = groupsVK?[indexPath.row] else { return }
//            let ownerGroup = self.groupsVK![indexPath.row]
//            self.groupService.leftGroups(for: ownerGroup.id)
//
//            RealmProvider.delete([mygroup])
//
//        }
//    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let ownerGroup = self.groupsVK?[indexPath.row]
        let delAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            print("Del Action Tapped")
            //self.tableView.deleteRows(at: [indexPath], with: .fade)
//            do {
//                let realm = try Realm()
//                realm.beginWrite()
//                realm.delete(ownerGroup!)
//                try realm.commitWrite()
//            } catch {
//                print(error)
//            }
            RealmProvider.delete([ownerGroup!])
            tableView.reloadData()

        }
        delAction.backgroundColor = .red
        //self.groupService.leftGroups(for: ownerGroup.id)
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
    
    private func pairTableAndRealm() {
        
        groupsVK = try? RealmProvider.get(Group.self)
        notificationToken = groupsVK?.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_, let dels, let ins, let mods):
                self.tableView.applyChanges(deletions: dels, insertions: ins, updates: mods)
            case .error(let error):
                print(error)
            }
        }
    }
//        groupsVK = realm.objects(Group.self)
//        notificationToken = groupsVK.observe({ [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = self?.tableView else {
//                return
//            }
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case let .update(results,_ ,_ ,_ ):
//                self?.groupsVK = results.sorted(byKeyPath: "name", ascending: false)
//                tableView.reloadData()
//            case .error(let error):
//                fatalError("\(error)")
//            }
//        })
    
    
}


