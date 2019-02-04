//
//  PhotoCollectionController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 27/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PhotoCollectionController: UICollectionViewController {
    var photoFriend: String = ""

   
   
    

    //var dividedArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoIDCell", for: indexPath) as! PhotoViewCollectionCell
        cell.photoFriendView.image = UIImage(named: photoFriend)
  
    
        //cell.photoFriendView.image = UIImage(named: photoFriend)

//        let photo = photoFriend[indexPath.row]
//        cell.photoFriendView.image = UIImage(named: photo)
        //cell.photoFriendView.image = UIImage(named: photoFriend)

    
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
        
        
        
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
