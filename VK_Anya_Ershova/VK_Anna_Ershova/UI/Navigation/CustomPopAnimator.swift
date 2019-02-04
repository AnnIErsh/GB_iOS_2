//
//  CustomPopAnimator.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        
        
        destination.view.frame = source.view.frame
        let h = destination.view.frame.height
        let w = destination.view.frame.width
        let dy = h / 2
        let dx = (h + w) / 2
        let alpha = 90.degreesToRadians

//        let translation = CGAffineTransform(translationX: -50, y: 0)
//        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
//
//        destination.view.transform = translation.concatenating(scale)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using:
            transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
//                                    UIView.addKeyframe(withRelativeStartTime: 0,
//                                                       relativeDuration: 0.4,
//                                                       animations: {
//                                                        let translation =
//                                                            CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
//                                                        let scale =
//                                                            CGAffineTransform(scaleX: 1.2, y: 1.2)
//                                                        source.view.transform =
//                                                            translation.concatenating(scale)
//                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.8,
                                                       animations: {
                                                    
                                                        let rotatingAlpha = CGAffineTransform(rotationAngle: -alpha)
                                                        let translationDxDy = CGAffineTransform(translationX: dx, y: -dy)
                                                        source.view.transform = rotatingAlpha.concatenating(translationDxDy)
                                                        
                                    })
//                                    UIView.addKeyframe(withRelativeStartTime: 0.25,
//                                                       relativeDuration: 0.75,
//                                                       animations: {
//                                                        destination.view.transform = .identity
//                                    })
                                    
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                //source.removeFromParent()
            //} else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished &&
                !transitionContext.transitionWasCancelled)
        }

    }
}


//{ finished in
//    if finished && !transitionContext.transitionWasCancelled {
//        source.removeFromParent()
//    } else if transitionContext.transitionWasCancelled {
//        destination.view.transform = .identity
//    }
//    transitionContext.completeTransition(finished &&
//        !transitionContext.transitionWasCancelled)
//}
