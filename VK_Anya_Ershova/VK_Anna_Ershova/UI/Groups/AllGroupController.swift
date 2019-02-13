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
    

    var groupsAll = ["Emo", "Goth", "Punk", "Peace", "Barbie", "Bratz", "Myscene", "Monsterhigh"]
    
    var allgroupsVK = [GlobalGroup]()
    var allgroupService = VKService()
    var groupname = [String]()

    
    var filterGr: [String] = []
    var isSearch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterGr = groupsAll
        
        allgroupService.searchGlobalGroups(){ [weak self] allgroupsVK, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let allgroupsVK = allgroupsVK, let self = self {
                self.allgroupsVK = allgroupsVK
                
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
      
//        if isSearch {
//            return filterGr.count
//        } else {
//            return groupsAll.count
//        }
        return allgroupsVK.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as! AllGroupCell
        
        // _ = (searchController.isActive) ? searchResult[indexPath.row] : groupsAll[indexPath.row]

        if isSearch {
//            let groups = filterGr[indexPath.row]
//            let img = UIImage(named: groups)
//            cell.configure(friend: groups, img: img!)
            cell.configured(with: allgroupsVK[indexPath.row])
        
        } else {
//            let groups = groupsAll[indexPath.row]
//            let img = UIImage(named: groups)
//            cell.configure(friend: groups, img: img!)
            cell.configured(with: allgroupsVK[indexPath.row])
        }
 
    

        
//        cell.grdAllName.text = groupsAll[indexPath.row]
//        let groups = groupsAll[indexPath.row]
//        cell.configure(friend: groups, img: UIImage(named: groups)!)

        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if searchText != "" {
            isSearch = true
            filterGr = groupsAll.filter({ (group) -> Bool in
                group.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()

        } else {
            isSearch = false
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
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        searchBar.text = ""
        tableView.reloadData()

    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        _ = tableView.dataSource
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}

