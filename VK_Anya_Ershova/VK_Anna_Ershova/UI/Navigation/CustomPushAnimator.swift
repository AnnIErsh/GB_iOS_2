//
//  CustomPushAnimator.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/31/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        
        let h = destination.view.frame.height
        let w = destination.view.frame.width
        let dy = h / 2
        let dx = (h + w) / 2
        let alpha = 90.degreesToRadians
        
        let rotatingAlpha = CGAffineTransform(rotationAngle: -alpha)
        let translationDxDy = CGAffineTransform(translationX: dx, y: -dy)
        
        destination.view.transform = rotatingAlpha.concatenating(translationDxDy)

        UIView.animateKeyframes(withDuration: self.transitionDuration(using:
            transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
//                                    UIView.addKeyframe(withRelativeStartTime: 0,
//                                                       relativeDuration: 0.75,
//                                                       animations: {
//                                                        let translation =
//                                                            CGAffineTransform(translationX: -50, y: 0)
//                                                        let scale =
//                                                            CGAffineTransform(scaleX: 0.8, y: 0.8)
//                                                        source.view.transform =
//                                                            translation.concatenating(scale)
//                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.8,
                                                       animations: {
                                                        let rotatingAlpha = CGAffineTransform(rotationAngle: 0)
                                                        let translationDxDy = CGAffineTransform(translationX: 0, y: 0)
                                                        
                                                        destination.view.transform = rotatingAlpha.concatenating(translationDxDy)
                                    })
//                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
//                                                       relativeDuration: 0.4,
//                                                       animations: {
//                                                        destination.view.transform =
//                                                            .identity
//                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }

}
