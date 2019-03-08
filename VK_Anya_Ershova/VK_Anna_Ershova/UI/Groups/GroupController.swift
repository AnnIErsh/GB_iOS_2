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
    
    private static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    
    var groupsVK: Results<Group> = {
        let groupObject = realm.objects(Group.self)
        return groupObject
    }()
    var groupService = VKService()
    var groupname = [String]()
    
    private var firebaseVK = [FirebaseVK]()
    private let ref = Database.database().reference(withPath: "groups")
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
   
        groupService.loadGroups()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pairTableAndRealm()
        
        
    }
    
    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let gr = groupsVK[indexPath.row]
            self.groupService.leftGroups(for: gr.id)
            RealmProvider.delete([gr])
    
        }
    }
    
    private func pairTableAndRealm() {
        
        groupsVK = try! RealmProvider.get(Group.self)
        notificationToken = groupsVK.observe { [weak self] changes in
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
    
    
}


