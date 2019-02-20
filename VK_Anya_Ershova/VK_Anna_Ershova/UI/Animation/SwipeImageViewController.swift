//
//  SwipeImageViewController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/28/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class SwipeImageViewController: UIViewController {
    
    
    @IBOutlet weak var swipeImgView: UIImageView!
    
    
    var photosFriends = [Photo]()
    let photoService = VKService()
    var index = 0
    var ownerId: Int = 0
    
    var swImg = UIImageView()
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        photoService.loadPhoto(ownerId: ownerId) { [weak self] photosFriends, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            } else if let photosFriends = photosFriends, let self = self {
//                self.photosFriends = photosFriends
//
//
//
//                DispatchQueue.main.async {
//                    //self.view.reloadInputViews()
//                    self.swImg.kf.setImage(with: URL(string: photosFriends[self.index].photoURL))
//                    self.swImg.frame = UIScreen.main.bounds
//                    self.swImg.contentMode = .scaleAspectFit
//                    //self.view.addSubview(self.swImg)
//                    self.view.backgroundColor = UIColor.darkGray
//                    self.swipeImgView.contentMode = .scaleAspectFit
//                    self.swipeImgView.backgroundColor = UIColor.darkGray
//                }
//
//            }
//
//        }
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService.loadPhoto(ownerId: Session.shared.userId) { [weak self] photosFriends, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let photosFriends = photosFriends, let self = self {
                self.photosFriends = photosFriends
                
                
                
                DispatchQueue.main.async {
                    //self.view.reloadInputViews()
                    self.swImg.kf.setImage(with: URL(string: photosFriends[self.index].photoURL))
                    self.swImg.frame = UIScreen.main.bounds
                    self.swImg.contentMode = .scaleAspectFit
                    //self.view.addSubview(self.swImg)
                    self.view.backgroundColor = UIColor.darkGray
                    self.swipeImgView.contentMode = .scaleAspectFit
                    self.swipeImgView.backgroundColor = UIColor.darkGray
                }
                
            }
            
        }
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        
        
        
    }
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if index == photosFriends.count - 1 {
                    index = 0
                    
                }else{
                    index += 1
                }
                swipeImgView.kf.setImage(with: URL(string: photosFriends[self.index].photoURL))
                swipeLeft()
                view.addSubview(swImg)
                
            case UISwipeGestureRecognizer.Direction.right:
                if index == 0 {
                    index = photosFriends.count - 1
                }else{
                    index -= 1
                }
                
                swipeImgView.kf.setImage(with: URL(string: photosFriends[self.index].photoURL))
                swipeRight()
                
                
            case UISwipeGestureRecognizer.Direction.down:
                self.performSegue(withIdentifier: "swipeDown", sender: self)
                
                
            default:
                break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func swipeLeft() {
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                                        self.swImg.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                                        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                                        opacityAnimation.fromValue = 1
                                        opacityAnimation.toValue = 0
                                        opacityAnimation.duration = 0.8
                                        self.swImg.layer.add(opacityAnimation, forKey: nil)
                                        
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                       relativeDuration: 0.8, animations: {
                                                        self.swImg.alpha = 0
                                                        let animation = CABasicAnimation(keyPath: "position.x")
                                                        animation.fromValue = self.swipeImgView.layer.bounds.origin.x + 800
                                                        animation.toValue =  self.swipeImgView.layer.bounds.origin.x
                                                        animation.duration = 0.8
                                                        self.swipeImgView.layer.add(animation, forKey: nil)
                                                        
                                    })
                                    
                                    
        }, completion: {[weak self] finished in
            self!.swImg.kf.setImage(with: URL(string: self!.photosFriends[self!.index].photoURL))
            self!.swImg.transform = .identity})
    }
    
    private func swipeRight() {
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.5,
                                                       animations: {
                                                        
                                                        let animation = CABasicAnimation(keyPath: "position.x")
                                                        animation.fromValue = self.swImg.layer.bounds.origin.x
                                                        animation.toValue = self.swImg.layer.bounds.origin.x + 1000
                                                        animation.duration = 0.8
                                                        self.swImg.layer.add(animation, forKey: nil)
                                                        
                                                        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                                                        opacityAnimation.fromValue = 1
                                                        opacityAnimation.toValue = 0
                                                        opacityAnimation.duration = 0.8
                                                        self.swImg.layer.add(opacityAnimation, forKey: nil)
                                                        
                                    })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                       relativeDuration: 0.8,
                                                       animations: {
                                                        //
                                                        let animation = CABasicAnimation(keyPath: "transform.scale")
                                                        animation.fromValue = 0.4
                                                        animation.toValue = 1
                                                        animation.duration = 0.8
                                                        self.swipeImgView.layer.add(animation, forKey: nil)
                                                        
                                    })
                                    
                                    
        }, completion: {[weak self] finished in
            var counter: Int {
                if self!.index == self!.photosFriends.count - 1 {return 0}
                else {return self!.index + 1}
            }
            self!.swImg.kf.setImage(with: URL(string: self!.photosFriends[counter].photoURL))
            self!.swImg.transform = .identity})
    }
    
    
}
