//
//  AllGroupController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 28/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import Firebase


class AllGroupController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarGroups: UISearchBar!
    var realm = RealmProvider()
    
    private var firebaseVK = [FirebaseVK]()
    private let ref = Database.database().reference(withPath: "Allroups")
    
    
    var allgroupsVK = [Group]()
    var allgroupService = VKService()
    var groupname = [String]()
    
    
    var filterGr = [Group]()
    var nofilterGr = [Group]()
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterGr = allgroupsVK
        observeFirebaseGroups()
        
    }
    
    func observeFirebaseGroups() {
        ref.observe(DataEventType.value) { snapshot in
            var groups: [FirebaseVK] = []
            
            for child in snapshot.children {
                guard let snapshot = child as? DataSnapshot,
                    let group = FirebaseVK(snapshot: snapshot) else { continue }
                
                groups.append(group)
            }
            
            self.firebaseVK = groups
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch {
            return filterGr.count
        } else {
            return allgroupsVK.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as! AllGroupCell
        
        if isSearch {
            
            cell.configured(with: filterGr[indexPath.row])
            
        } else {
            
            
            cell.configured(with: allgroupsVK[indexPath.row])
        }
        
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if searchText != "" {
            isSearch = true
            allgroupService.searchGroups(isSearching: searchText){ [weak self] allgroupsVK, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let allgroupsVK = allgroupsVK, let self = self {
                    self.filterGr = allgroupsVK
                    //FirebaseVK.searchStory(searchText: searchText)
                    
                    //self.ref.setValue(FirebaseVK(uid: Session.shared.token, uidInt: Session.shared.userId).toAnyObject())
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }
            
        } else {
            isSearch = false
            filterGr = allgroupsVK.filter({( groups ) -> Bool in
                return groups.name.lowercased().contains(searchText.lowercased())})
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        searchBar.text = ""
        
        self.tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let globalGroup = self.filterGr[indexPath.row]
        let addAction = UITableViewRowAction(style: .destructive, title: "Add") { (action, indexpath) in
            print("Add Action Tapped")
            //self.allgroupsVK.append(globalGroup)
            //self.filterGr.remove(at: indexPath.row)
            //self.tableView.reloadData()
            
        }
        
        
        addAction.backgroundColor = .green
        self.allgroupService.addGroups(groupId: globalGroup.id){ [weak self] groups, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groups = groups, let self = self {
                
                RealmProvider.saveItems(items: groups)
                self.filterGr.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        //FirebaseVK.checkedGroups(group: globalGroup)
        //self.performSegue(withIdentifier: "add", sender: indexPath)
        return [addAction]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "add",
            let destinationVC = segue.destination as? GroupController,
            let row = tableView.indexPathForSelectedRow?.row  else { return }
        
        let gr = allgroupsVK[row]
        destinationVC.groupsVK = (gr.toAnyObject as! Results<Group>)
        
    }
    
}

