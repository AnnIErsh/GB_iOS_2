//
//  AllGroupController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 28/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
//import CoreData

class AllGroupController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarGroups: UISearchBar!
    
    
    //var groupsAll = ["Emo", "Goth", "Punk", "Peace", "Barbie", "Bratz", "Myscene", "Monsterhigh"]
    
    var allgroupsVK = [Group]()
    var allgroupService = VKService()
    var groupname = [String]()
    
    
    var filterGr = [Group]()
    var nofilterGr = [Group]()
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBarGroups.delegate = self
        filterGr = allgroupsVK
        
        //        allgroupService.searchGroups(isSearching: "Api"){ [weak self] allgroupsVK, error in
        //            if let error = error {
        //                print(error.localizedDescription)
        //                return
        //            } else if let allgroupsVK = allgroupsVK, let self = self {
        //                self.allgroupsVK = allgroupsVK
        //
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //            }
        //        }
        allgroupService.loadGroups(){ [weak self] groupsVK, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groupsVK = groupsVK, let self = self {
                self.allgroupsVK = groupsVK.filter {$0.name != ""}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
        //return allgroupsVK.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as! AllGroupCell
        
        // _ = (searchController.isActive) ? searchResult[indexPath.row] : groupsAll[indexPath.row]
        //let groups: String
        
        //let img = UIImageView()
        //let groups: String
        if isSearch {
            //let groups = filterGr[indexPath.row].name
            //           img.kf.setImage(with: URL(string: filterGr[indexPath.row].photo))
            cell.configured(with: filterGr[indexPath.row])
            
        } else {
            //            groups = allgroupsVK[indexPath.row].name
            //            img.kf.setImage(with: URL(string: allgroupsVK[indexPath.row].photo))
            
            cell.configured(with: allgroupsVK[indexPath.row])
        }
        //        groups = nofilterGr[indexPath.row].name
        //        img.kf.setImage(with: URL(string: nofilterGr[indexPath.row].photo))
        //cell.configured(with: nofilterGr[indexPath.row])
        //let groups: String
        //cell.grdAllName.text = groups
        
        
        
        
        //        cell.grdAllName.text = groupsAll[indexPath.row]
        //        let groups = groupsAll[indexPath.row]
        //        cell.configure(friend: groups, img: UIImage(named: groups)!)
        
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
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }
            //            filterGr = allgroupsVK.filter({( groups ) -> Bool in
            //                return groups.name.lowercased().contains(searchText.lowercased())})
            
            //tableView.reloadData()
            
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
    
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //        isSearch = true
    //        tableView.reloadData()
    //
    //    }
    
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
            self.filterGr.remove(at: indexPath.row)
            //self.performSegue(withIdentifier: "add", sender: indexPath)
            tableView.reloadData()
            
        }
        addAction.backgroundColor = .green
        self.allgroupService.addGroups(groupId: globalGroup.id)
        self.performSegue(withIdentifier: "add", sender: indexPath)
        //tableView.reloadData()
        return [addAction]
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let destinationVC : GroupController = segue.destination as! GroupController
            let sourceVC = segue.source as! AllGroupController
            if let indexPath = sourceVC.tableView.indexPathForSelectedRow {
                let addNewGroup = sourceVC.allgroupsVK[indexPath.row]
                destinationVC.groupsVK[indexPath.row] = addNewGroup
                self.tableView.reloadData()
            }
        }
    }
    
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            allgroupsVK.remove(at: indexPath.row)
    //            allgroupService.leftGroups(for: allgroupsVK[indexPath.row].id)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //            tableView.reloadData()
    //        }
    
    //        if editingStyle == .insert {
    //            allgroupsVK.append(filterGr[indexPath.row])
    //            allgroupService.addGroups(groupId: filterGr[indexPath.row].id)
    //            tableView.insertRows(at: [indexPath], with: .automatic)
    //            tableView.reloadData()
    //        }
    //   }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        _ = tableView.dataSource
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
}

