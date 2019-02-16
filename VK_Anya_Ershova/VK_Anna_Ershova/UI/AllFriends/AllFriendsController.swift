//
//  AllFriendsController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 26/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import Kingfisher



class AllFriendsController: UITableViewController, UISearchBarDelegate {
    
    
    private let userService = VKService()
    var users = [User]()
    var friendId = 0
    //var fullname = [String]()
    //    public var firstname = [String]()
    //var fullImage = [String]()
    
    
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private var friendsIndexTitles = [String]()
    //["C","D","H","I","J","M","S","T", "W", "Y"]
    //let searchController = UISearchController(searchResultsController: nil)
    
    //var dividedArray: NSMutableArray = []
    //var devider = [""]
    
    var isSearch = false
    var filterFr = [User]()
    var nofilterFr = [User]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userService.loadFriends() { [weak self] users, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let users = users, let self = self {
                self.users = users
                
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
        //        for index in friendsIndexTitles{
        //            let helpArray: NSMutableArray = []
        //            for jndex in friends {
        //                if index.first!  == jndex.first! {
        //                    helpArray.add(jndex)
        //                }
        //            }
        //            dividedArray.add(helpArray)
        //        }
        //        searchBar.frame = CGRect(x: 15, y: 100, width: 350, height: 50)
        //        showSearchBar()
        //        searchBar.layoutIfNeeded()
        //        self.view.addSubview(searchBar)
        //        searchBar.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        //        searchBar.delegate = self
        //        view.addSubview(searchBar)
        showSearchBar()
        
//
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return 1
        } else {
            return filteringText(in: users).count
            //return friendsIndexTitles.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            //devider = filterFr
            return filter(of: filterFr, in: section).count
        } else {
            
            return filter(of: users, in: section).count
            // devider = fullname.filter {$0[$0.startIndex] == Character(friendsIndexTitles[section])}
        }
        //return (dividedArray[section] as! NSMutableArray).count
        //return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! AllFriendsCell
        //let friendUser = users[indexPath.row]
        var friendAfter = [User]()
        if isSearch {
            //devider = filterFr
            friendAfter = filter(of: filterFr, in: indexPath.section)
            //cell.friendName.text = friendAfter[indexPath.row].name
        } else {
            
            friendAfter = filter(of: users, in: indexPath.section)
            //
            //            let helpArray = dividedArray[indexPath.section] as! NSMutableArray
            //            let friend = helpArray[indexPath.row] as? String
            //            let img = UIImage(named: friend!)
            //
            //            cell.friendName.text = friend
            //            cell.configure(friend: friend!, img: img!)
            
            //devider = fullname.filter {$0[$0.startIndex] == Character(friendsIndexTitles[indexPath.section]) }
            //let friend = devider[indexPath.row]
            //let img = UIImage(named: friend)
            cell.configured(with: users[indexPath.row])
        }
        
        //let friend = devider[indexPath.row]
        //let img = UIImage(named: friend)
        cell.configured(with: friendAfter[indexPath.row])
        
        //        let helpArray = dividedArray[indexPath.section] as! NSMutableArray
        //        let friend = helpArray[indexPath.row] as? String
        //        let img = UIImage(named: friend!)
        //
        //        cell.friendName.text = friend
        //        cell.configure(friend: friend!, img: img!)
        //        let img = images[indexPath.row]
        //        cell.imageName.image = UIImage(named: img)
        
        // container for image
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
            //return self.friendsIndexTitles
            
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
            //return self.friendsIndexTitles
            
        }
    }
    
    
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showPhoto" {
    //            let destinationVC : PhotoCollectionController = segue.destination as! PhotoCollectionController
    //            let sourceVC = segue.source as! AllFriendsController
    //            if let indexPath = sourceVC.tableView.indexPathForSelectedRow {
    //                if isSearch {
    //                    devider = filterFr
    //                } else {
    //
    //                    devider = fullname.filter {$0[$0.startIndex] == Character(friendsIndexTitles[indexPath.section]) }
    //                }
    //                let photoFriend = sourceVC.devider[indexPath.row]
    //                destinationVC.photoFriend = photoFriend
    //
    //            }
    //        }
    //
    //    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = segue.destination as! PhotoCollectionController
                var friendAfter = [User]()
                
                if isSearch {
                    
                    friendAfter = filter(of: filterFr, in: indexPath.section)
                    
                } else {
                    
                    friendAfter = filter(of: users, in: indexPath.section)
                    
                }
                controller.ownerId = friendAfter[indexPath.row].id
            }
        }
        
    }
    
    internal override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secView = UIView()
        secView.backgroundColor = tableView.backgroundColor!.withAlphaComponent(0.5)
        
        
        let secText = UILabel()
        //secText.text = friendsIndexTitles[section] as String
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
            userService.searchFriends(isSearching: searchText){ [weak self] users, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let users = users, let self = self {
                    self.users = users
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }
            filterFr = users.filter({( group ) -> Bool in
                return group.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            isSearch = false
            self.tableView.reloadData()
        }

       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //isSearch = false
        self.tableView.reloadData()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 500.0, initialSpringVelocity: 0, options: .overrideInheritedDuration, animations: {
        //            self.searchBar.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        //        })
        //        let spinner = UIActivityIndicatorView(style: .gray)
        //        spinner.center = CGPoint(x: 160, y: 0)
        //        spinner.hidesWhenStopped = true
        //        spinner.tag = 7
        //        self.searchBar.addSubview(spinner)
        searchBar.frame = CGRect(x: 8, y: 0, width: 350, height: 50)
        animationBar()
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        //        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 500.0, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
        //            self.searchBar.frame = CGRect(x: 100, y: 0, width: 350, height: 50)
        //        })
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
            
            //searchBarTextField.textAlignment = .center
            //searchBar.frame = CGRect(x: 8, y: 0, width: 350, height: 50)
            //Center placeholder
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
    
    func filteringSearchingText(for text: String, _ : String = "All"){
        filterFr = users.filter({( group ) -> Bool in
            return group.name.lowercased().contains(text.lowercased()) || group.name.lowercased().contains(text.lowercased())})
        self.tableView.reloadData()
    }
    
    func filter (of users: [User], in section: Int) -> [User] {
        let key = filteringText(in: users)[section]
        return users.filter { $0.name.first! == Character(key) }
    }
    
    func filteringText (in users: [User]) -> [String] {
        var initText = [String]()
        for user in users {
            initText.append(String(user.name.first!))
        }
        return Array(Set(initText)).sorted()
    }
    

    
}


