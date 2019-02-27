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
    
    var photosFriends = Array<Photo>()
    var photoService = VKService()
    var ownerId: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService.loadPhoto(ownerId: ownerId) { [weak self] photosFriends, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let photosFriends = photosFriends, let self = self {
                self.photosFriends = photosFriends
                
                RealmProvider.saveItems(items: photosFriends)
                
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
            
        }
        
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        photosFriends = Array(realm.objects(Photo.self)).filter {$0.photoId == ownerId}
        
        
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
        
        
        //        let animationIn = CASpringAnimation(keyPath: "transform.scale")
        //        animationIn.fromValue = 1
        //        animationIn.toValue = 0.8
        //        animationIn.stiffness = 100
        //        animationIn.mass = 0.5
        //        animationIn.duration = 0.5
        //        animationIn.beginTime = CACurrentMediaTime()
        //        animationIn.fillMode = CAMediaTimingFillMode.backwards
        //        cell.photoFriendView.layer.add(animationIn, forKey: nil)
        cell.configured(with: photosFriends[indexPath.row])
        
        
        
        
        return cell
    }
    
    
}
