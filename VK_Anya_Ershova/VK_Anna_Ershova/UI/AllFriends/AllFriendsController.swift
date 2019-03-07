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
import FirebaseDatabase
import FirebaseAuth



class AllFriendsController: UITableViewController, UISearchBarDelegate {
    
    var notificationToken: NotificationToken?
    let realmProvider = RealmProvider()
    private let userService = VKService()
    private static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    var users: Results<User> = {
        let userObject = realm.objects(User.self)
        return userObject
    }()
    var filterFr: Results<User> = {
        let userObject = realm.objects(User.self)
        return userObject
    }()
    
    private var firebaseVK = [FirebaseVK]()
    private let ref = Database.database().reference(withPath: "users")
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
                
                self.realmProvider.save(items: users.filter {$0.name != ""})
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
        self.tableView.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
    
    override func viewDidLoad() {
        // tableView.reloadData()
        super.viewDidLoad()
        showSearchBar()
        pairTableAndRealm()
        
        
        
        
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            //            let user = authResult.user
            //            let isAnonymous = user.isAnonymous  // true
            //            let uid = user.uid
            let user = authResult?.user
            guard let uid = user?.uid else { return }
            let firebaseVK = FirebaseVK(uid: uid, uidInt: Session.shared.userId)
            let firebaseRef = self.ref.child(Session.shared.token)
            firebaseRef.updateChildValues(firebaseVK.toAnyObject())
        }
        
        ref.observe(.value, with: { snapshot in
            var firebaseVK = [FirebaseVK]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let firebase = FirebaseVK(snapshot: snapshot) {
                    firebaseVK.append(firebase)
                }
            }
            self.firebaseVK = firebaseVK
        })
        
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
                controller.photoId = friendAfter[indexPath.row].id
            }
        }
        
    }
    
    internal override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secView = UIView()
        secView.backgroundColor = tableView.backgroundColor!.withAlphaComponent(0.5)
        
        
        let secText = UILabel()
        secText.frame = CGRect(x: 5, y: 5, width: 80, height: 30)
        if isSearch {
            secText.text = filteringText(in: filterFr)[section]
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
            filterFr = users.filter("name CONTAINS[cd] %@", searchText)
            tableView.reloadData()
        } else {
            isSearch = false
            tableView.reloadData()
        }
        
        
        
        
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
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let opacityDown = CABasicAnimation(keyPath: "opacity")
        opacityDown.beginTime = CACurrentMediaTime()
        opacityDown.fromValue = 1
        opacityDown.toValue = 0
        opacityDown.duration = 0.8
        opacityDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        cell.layer.add(opacityDown, forKey: nil)
    }
    
}

extension AllFriendsController {
    
    func filteringText (in users: Results<User>) -> [String] {
        var friendsIndexTitles = [String]()
        for user in users {
            //friendsIndexTitles.append(String(user.lastname.first!))
            if let letter = user.lastname.first {
                friendsIndexTitles.append(String(letter))
            } else {
                let letter = user.firstname.first
                friendsIndexTitles.append(String(letter!))
            }
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
    
    
    
    
}


