//
//  AllFriendsController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 26/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit



class AllFriendsController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Private Properties
    private var friends = ["Cameron", "Chloe", "Jade", "Sasha", "Yasmin", "Dipper", "Mabel", "Stanly", "Will", "Irma", "Taranee", "Cornelia", "Haylin"].sorted(by: {$0 < $1})
    
    // private var images = ["Cameron", "Chloe", "Jade", "Sasha", "Yasmin", "Dipper", "Mabel", "Stanly", "Will", "Irma", "Taranee", "Cornelia", "Haylin"]
    
    
    private var friendsIndexTitles = ["C","D","H","I","J","M","S","T", "W", "Y"]
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    //var dividedArray: NSMutableArray = []
    var devider = [""]
    
    var isSearch = false
    var filterFr = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        
        
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return 1
        } else {
            return friendsIndexTitles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            devider = filterFr
        } else {
            devider = friends.filter {$0[$0.startIndex] == Character(friendsIndexTitles[section])
            }
        }
        //return (dividedArray[section] as! NSMutableArray).count
        return devider.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! AllFriendsCell
        
        
        if isSearch {
            devider = filterFr
            cell.friendName.text = devider[indexPath.row]
        } else {
            //
            //            let helpArray = dividedArray[indexPath.section] as! NSMutableArray
            //            let friend = helpArray[indexPath.row] as? String
            //            let img = UIImage(named: friend!)
            //
            //            cell.friendName.text = friend
            //            cell.configure(friend: friend!, img: img!)
            
            devider = friends.filter {$0[$0.startIndex] == Character(friendsIndexTitles[indexPath.section]) }
            let friend = devider[indexPath.row]
            let img = UIImage(named: friend)
            cell.configure(friend: friend, img: img!)
        }
        
        let friend = devider[indexPath.row]
        let img = UIImage(named: friend)
        cell.configure(friend: friend, img: img!)
        
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
            return self.friendsIndexTitles
            
        }
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    internal override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.friendsIndexTitles[section] as String
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let destinationVC : PhotoCollectionController = segue.destination as! PhotoCollectionController
            let sourceVC = segue.source as! AllFriendsController
            if let indexPath = sourceVC.tableView.indexPathForSelectedRow {
                if isSearch {
                    devider = filterFr
                } else {
                    
                    devider = friends.filter {$0[$0.startIndex] == Character(friendsIndexTitles[indexPath.section]) }
                }
                let photoFriend = sourceVC.devider[indexPath.row]
                destinationVC.photoFriend = photoFriend
                
            }
        }
        
    }
    
    
    internal override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secView = UIView()
        secView.backgroundColor = tableView.backgroundColor!.withAlphaComponent(0.5)
        
        
        let secText = UILabel()
        secText.text = friendsIndexTitles[section] as String
        secText.frame = CGRect(x: 5, y: 5, width: 80, height: 30)
        if isSearch {
            secText.text = "..."
        } else {
            secText.text = friendsIndexTitles[section]
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
            filterFr = friends.filter({ (group) -> Bool in
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
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
        tableView.reloadData()
    }
    
    //    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    //        searchBar.setShowsCancelButton(false, animated: true)
    //        return true
    //    }
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
        tableView.reloadData()
    }
    
    //    func searchBarIsEmpty() -> Bool {
    //        return searchController.searchBar.text?.isEmpty ?? true
    //    }
    
    private func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        isSearch = false
        tableView.reloadData()
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




