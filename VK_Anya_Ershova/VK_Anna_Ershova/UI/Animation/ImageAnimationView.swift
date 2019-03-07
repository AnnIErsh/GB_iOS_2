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
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        recognizer(self)
    }
    
}
