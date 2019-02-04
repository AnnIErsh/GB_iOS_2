//
//  ImageAnimationView.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/24/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class ImageAnimationView: UIImageView {
    
    var index = 0
    var interactiveAnimator: UIViewPropertyAnimator!
    
    private func recognizer(_ sender: UIImageView){
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(animationImg))
        recognizer.numberOfTapsRequired = 1
        sender.isUserInteractionEnabled = true
        sender.addGestureRecognizer(recognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    @objc func animationImg() {
        
//        interactiveAnimator?.startAnimation()
//        
//        interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
//                                                     dampingRatio: 0.5,
//                                                     animations: {
//                                                        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)  })

        let imageUp = CASpringAnimation(keyPath: "transform.scale")
        imageUp.fromValue = 1
        imageUp.toValue = 0.7
        imageUp.stiffness = 100
        imageUp.mass = 0.4
        imageUp.duration = 0.2
        imageUp.beginTime = CACurrentMediaTime()
        imageUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        imageUp.fillMode = CAMediaTimingFillMode.backwards
        layer.add(imageUp, forKey: nil)

        let imageDown = CASpringAnimation(keyPath: "transform.scale")
        imageDown.fromValue = 0.7
        imageDown.toValue = 1
        imageDown.stiffness = 200
        imageDown.mass = 1
        imageDown.duration = 2
        imageDown.beginTime = CACurrentMediaTime() + imageUp.duration
        imageDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        imageDown.fillMode = CAMediaTimingFillMode.both
        layer.add(imageDown, forKey: nil)
    }
    
//    @objc func animationImg(_ recognizer: UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            interactiveAnimator?.startAnimation()
//
//            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
//                                                         dampingRatio: 0.5,
//                                                         animations: {
//                                                            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            })
//            interactiveAnimator.pauseAnimation()
//
//        case .changed:
//
//            let translation = recognizer.translation(in: self)
//
//            interactiveAnimator.fractionComplete = translation.y / 100
//                        if index == newsAll.count - 1 {
//                            index = 0
//                        }else{
//                            index += 1
//
//                        }
//
//
//
//        case .ended:
//            //interactiveAnimator.stopAnimation(true)
//
//            interactiveAnimator.addAnimations {
//                self.transform = .identity
//            }
//            interactiveAnimator.startAnimation()
//
//            UICollectionViewCell.image = UIImage(named: newsAll[index])
//
//        default: return
//        }
//    }

    
    
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        recognizer(self)
    }
    
    
    
    //    self.animationImages = viewToAnimate
    //    self.animationDuration = 0.25
    //    self.startAnimating()
    
    //    photoView.hidden = true
    //    UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.ShowHideTransitionViews, animations: { () -> Void in
    //    self.photoView.hidden = false
    //    }, completion: { (Bool) -> Void in    }
    //    )
}
