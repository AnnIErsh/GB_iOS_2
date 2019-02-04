//
//  RefreshView.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/2/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

final class RefreshView: UIView {
    
    let ovalShapeLayer = CAShapeLayer()
    let airplaneLayer = CALayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        ovalShapeLayer.strokeColor = UIColor.black.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 4.0
        ovalShapeLayer.lineDashPattern = [2, 3]
        
        let refreshRadius = bounds.height/2 * 0.4
        
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(
            x: frame.size.width/2 - refreshRadius,
            y: frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius)
            ).cgPath
        
        layer.addSublayer(ovalShapeLayer)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 2
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
    }
}
