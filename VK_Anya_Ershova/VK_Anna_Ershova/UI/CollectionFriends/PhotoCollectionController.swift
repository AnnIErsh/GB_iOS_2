//
//  PhotoCollectionController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 27/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit
import RealmSwift



class PhotoCollectionController: UICollectionViewController {
    var photoFriend: String = ""
    
    //var photosFriends = Array<Photo>()
    
    let realmProvider = RealmProvider()
    var photoService = VKService()
    var photoId: Int = 0
    
    var notificationToken: NotificationToken?
    
    static var realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    
    var photosFriends: Results<Photo> = {
        let photoObject = realm.objects(Photo.self)
        return photoObject
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.photoService.loadPhoto(photoOwnerId: photoId) { [weak self] photosFriends, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let photosFriends = photosFriends, let self = self {
                self.realmProvider.save(items: photosFriends)
                RealmProvider.savePhotoForUser(photosFriends, id: self.photoId)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
            
        }
        pairCollectionAndRealm()
        
        
    }
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosFriends.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoIDCell", for: indexPath) as! PhotoViewCollectionCell
        
        
        
        // shadow view
        cell.photoFriendView.layer.shadowColor = UIColor.darkGray.cgColor
        cell.photoFriendView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 296, height: 296), cornerRadius: 0).cgPath
        cell.photoFriendView.layer.shadowOpacity = 0.8
        cell.photoFriendView.layer.shadowRadius = 5
        cell.photoFriendView.layer.shadowOffset = CGSize(width: 10, height: 8)
        cell.configured(with: photosFriends[indexPath.row])
        
        
        
        
        return cell
    }
    
    func pairCollectionAndRealm() {
        
        photosFriends = try! RealmProvider.get(Photo.self).filter("ANY photosForUser.id == %@", photoId)
        
        notificationToken = photosFriends.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
            case .update:
                collectionView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
//"ANY photosForUser.id == %@"
