//
//  SwipeImageViewController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/28/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class SwipeImageViewController: UIViewController {
    
    
    @IBOutlet weak var swipeImgView: UIImageView!
    
    
    var imageNames = ["Chloe", "Jade", "Sasha", "Yasmin", "Cameron", "Dipper", "Mabel", "Stanly"]
    var index = 0
    //var interactiveAnimator: UIViewPropertyAnimator!
    
    var swImg = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swImg.frame = UIScreen.main.bounds
        swImg.contentMode = .scaleAspectFit
        swImg.image = UIImage()
        view.backgroundColor = UIColor.darkGray
        swipeImgView.contentMode = .scaleAspectFit
        swipeImgView.backgroundColor = UIColor.darkGray
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        
        
        
        
        //        let recognizerBegan = UIPanGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        //        recognizerBegan.state = UIPanGestureRecognizer.State.began
        //        self.view.addGestureRecognizer(recognizerBegan)
        //
        //        let recognizerChanged = UIPanGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        //        recognizerBegan.state = UIPanGestureRecognizer.State.changed
        //        self.view.addGestureRecognizer(recognizerChanged)
        //
        //        let recognizerEnded = UIPanGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        //        recognizerEnded.state = UIPanGestureRecognizer.State.ended
        //        self.view.addGestureRecognizer(recognizerEnded)
        
        
        
        //
        //        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        //        self.view.addGestureRecognizer(recognizer)
        
        
    }
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if index == imageNames.count - 1 {
                    index = 0
                    
                }else{
                    index += 1
                }
                swipeImgView.image = UIImage(named: imageNames[index])
                swipeLeft()
                view.addSubview(swImg)
                
            case UISwipeGestureRecognizer.Direction.right:
                if index == 0 {
                    index = imageNames.count - 1
                }else{
                    index -= 1
                }
                
                swipeImgView.image = UIImage(named: imageNames[index])
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
    
    
    
    
    //    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
    //        switch recognizer.state {
    //        case .began:
    //            interactiveAnimator?.startAnimation()
    //
    //            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
    //                                                         dampingRatio: 0.5,
    //                                                         animations: {
    //                                                            self.swipeImgView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    //            })
    //            interactiveAnimator.pauseAnimation()
    //
    //        case .changed:
    //
    //            let translation = recognizer.translation(in: self.view)
    //
    //            interactiveAnimator.fractionComplete = translation.x / 100
    //            if index == imageNames.count - 1 {
    //                index = 0
    //                }else{
    //                index += 1
    //
    //            }
    //
    //
    //
    //        case .ended:
    //            interactiveAnimator.stopAnimation(true)
    //
    //            interactiveAnimator.addAnimations {
    //                self.swipeImgView.transform = .identity
    //            }
    //            interactiveAnimator.startAnimation()
    //
    //            swipeImgView.image = UIImage(named: imageNames[index])
    //
    //        default: return
    //        }
    //    }
    
    
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
            self!.swImg.image = UIImage(named: self!.imageNames[self!.index])
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
                if self!.index == self!.imageNames.count - 1 {return 0}
                else {return self!.index + 1}
            }
            self!.swImg.image = UIImage(named: self!.imageNames[counter])
            self!.swImg.transform = .identity})
    }
    
    
}
