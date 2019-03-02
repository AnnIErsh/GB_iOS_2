//
//  AllFriendsController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 26/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import KeyPathKit



class AllFriendsController: UITableViewController, UISearchBarDelegate {
    
    var notificationToken: NotificationToken?
    
    private let userService = VKService()
    private static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var users: Results<User> = {
        let userObject = realm.objects(User.self).sorted(byKeyPath: "lastname", ascending: true)
        return userObject
    }()
    var filterFr: Results<User> = {
        let userObject = realm.objects(User.self).sorted(byKeyPath: "lastname", ascending: true)
        return userObject
    }()
        
    
    var friendId = 0
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    var isSearch = false



    
    override func viewWillAppear(_ animated: Bool) {
        
        userService.loadFriends() { [weak self] users, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let users = users, let self = self {
//                self.users = users.filter("lastname BEGINSWITH %@").sorted(byProperty: "lastname")
                
                RealmProvider.saveItems(items: users.filter {$0.name != ""})
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
       
//        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//        let realm = try! Realm(configuration: config)
//        users = realm.objects(User.self)
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        // tableView.reloadData()
        super.viewDidLoad()
        showSearchBar()
        pairTableAndRealm()
        
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return filteringText(in: filterFr).count
        } else {
            return filteringText(in: users).count
            //return friendsIndexTitles.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return filterFriends(of: filterFr, in: section).count
        } else {
            
            return filterFriends(of: users, in: section).count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! AllFriendsCell
        
        var friendAfter: Results<User>
        if isSearch {
            
            friendAfter = filterFriends(of: filterFr, in: indexPath.section)
            
        } else {
            
            friendAfter = filterFriends(of: users, in: indexPath.section)
            
            cell.configured(with: users[indexPath.row])
        }
        
        cell.configured(with: friendAfter[indexPath.row])
        
        let myImage = UIImageView(frame: cell.imageName.bounds)
        myImage.clipsToBounds = true
        myImage.layer.cornerRadius = 10
        cell.imageName.addSubview(myImage)
        
        
        
        return cell
    }
    
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isSearch {
            return nil
        } else {
            return filteringText(in: users)
            
        }
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    internal override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearch {
            return nil
        } else {
            return filteringText(in: users)[section]
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = segue.destination as! PhotoCollectionController
                var friendAfter: Results<User>
                if isSearch {
                    
                    friendAfter = filterFriends(of: filterFr, in: indexPath.section)
                    
                } else {
                    
                    friendAfter = filterFriends(of: users, in: indexPath.section)
                    
                }
                controller.ownerId = friendAfter[indexPath.row].id
            }
        }
        
    }
    
    internal override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secView = UIView()
        secView.backgroundColor = tableView.backgroundColor!.withAlphaComponent(0.5)
        
        
        let secText = UILabel()
        secText.frame = CGRect(x: 5, y: 5, width: 80, height: 30)
        if isSearch {
            secText.text = "..."
        } else {
            secText.text = filteringText(in: users)[section]
        }
        
        secView.addSubview(secText)
        
        return secView
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            isSearch = true
            filterFr = users.filter("firstname CONTAINS[cd] %@ OR lastname CONTAINS[cd] %@", searchText, searchText)
            tableView.reloadData()
        } else {
            isSearch = false
            tableView.reloadData()
        }
        
        
            
        
//        if searchText != "" {
            
//            userService.searchFriends(isSearching: searchText){ [weak self] users, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                } else if let users = users, let self = self {
//                    self.users = users.filter {$0.name != ""}
//                    //self.filterFr = users
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//
//                }
//
//            }
            //            filterFr = users.filter({( group ) -> Bool in
            //                return group.name.lowercased().contains(searchText.lowercased())
            //            })
 //       } else {
            //isSearch = false
        //          self.tableView.reloadData()
 //       }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        //refreshControl?.removeFromSuperview()
        self.tableView.reloadData()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.frame = CGRect(x: 8, y: 0, width: 350, height: 50)
        animationBar()
        return true
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.frame = CGRect(x: 8, y: 0, width: 350, height: 50)
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField!.textAlignment = .center
        let width = searchBar.frame.width / 2 - (searchBarTextField!.attributedPlaceholder?.size().width)!
        let paddingView = UIView(frame: CGRect(x: 8, y: 0, width: width, height: searchBar.frame.height))
        searchBarTextField!.leftView = paddingView
        searchBarTextField!.leftViewMode = .unlessEditing
        
        return true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        searchBar.text = ""
        self.tableView.reloadData()
    }
    
    private func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        isSearch = false
        self.tableView.reloadData()
    }
    
    
    
    public func showSearchBar() {
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            
            let width = searchBar.frame.width / 2 - (searchBarTextField.attributedPlaceholder?.size().width)!
            let paddingView = UIView(frame: CGRect(x: 8, y: 0, width: width, height: searchBar.frame.height))
            searchBarTextField.leftView = paddingView
            searchBarTextField.leftViewMode = .unlessEditing
            
        }
        
    }
    
    
    
    public func animationBar() {
        
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField!.textAlignment = .left
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = 245
        animation.toValue = 135
        animation.stiffness = 200
        animation.mass = 0.5
        animation.duration = 1
        //searchBar.layer.add(animation, forKey: nil)
        searchBarTextField!.layer.add(animation, forKey: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let opacityUp = CABasicAnimation(keyPath: "opacity")
        opacityUp.beginTime = CACurrentMediaTime()
        opacityUp.fromValue = 0
        opacityUp.toValue = 1
        opacityUp.duration = 0.8
        opacityUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        cell.layer.add(opacityUp, forKey: nil)
        //
        //        let scaleUp = CABasicAnimation(keyPath: "transform.scale")
        //        scaleUp.beginTime = CACurrentMediaTime()
        //        scaleUp.fromValue = 0.5
        //        scaleUp.toValue = 1
        //        scaleUp.duration = 0.3
        //        scaleUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        //        cell.layer.add(scaleUp, forKey: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let opacityDown = CABasicAnimation(keyPath: "opacity")
        opacityDown.beginTime = CACurrentMediaTime()
        opacityDown.fromValue = 1
        opacityDown.toValue = 0
        opacityDown.duration = 0.8
        opacityDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        cell.layer.add(opacityDown, forKey: nil)
        
        //        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        //        scaleDown.beginTime = CACurrentMediaTime()
        //        scaleDown.fromValue = 1
        //        scaleDown.toValue = 0.5
        //        scaleDown.duration = 0.3
        //        scaleDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        //        cell.layer.add(scaleDown, forKey: nil)
    }
    
}

extension AllFriendsController {
    
    func filteringText (in users: Results<User>) -> [String] {
        var friendsIndexTitles = [String]()
        for user in users {
            friendsIndexTitles.append(String(user.lastname.first!))
        }
        return Array(Set(friendsIndexTitles)).sorted()
    }
    
    func filterFriends (of users: Results<User>, in section: Int) -> Results<User> {
        let key = filteringText (in: users)[section]
        return users.filter("lastname BEGINSWITH %@", key)
    }
    
    func pairTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        users = realm.objects(User.self)
        notificationToken = users.observe ({ [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }

    
//    func filter (of users: Array<User>, in section: Int) ->  Array<User> {
//        let key = filteringText(in: users)[section]
//        return users.filter { $0.name.first! == Character(key) }
//    }
//
//    func filteringText (in users: Array<User>) -> [String] {
//        var initText = [String]()
//        for user in users {
//            initText.append(String(user.name.first!))
//        }
//        return Array(Set(initText)).sorted()
//    }
    
//    func queryUsers(){
//        let realm = try! Realm()
//        let allUsers = realm.objects(User.self)
//        for each in allUsers{
//            self.users.append(each)
//        }
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        self.users.removeAll()
//
//        DispatchQueue.main.async() {
//            if (textField.text?.count)! > 0{
//                let realm = try! Realm()
//                let predicate = NSPredicate(format: "name CONTAINS [c] %@", textField.text!)
//                let filteredUsers = realm.objects(User.self).filter(predicate)
//                for each in filteredUsers{
//                    self.users.append(each)
//                    //self.tableview.reloadData()
//                }
//            }else{
//                self.queryUsers()
//                self.tableView.reloadData()
//            }
//        }
//        self.tableView.reloadData()
//
//        return true
//    }
    
    
    
    
}


