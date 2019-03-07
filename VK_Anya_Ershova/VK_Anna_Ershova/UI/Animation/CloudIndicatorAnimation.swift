//
//  CloudIndicatorAnimation.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/2/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

final class CloudIndicatorAnimation: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = makeCloudPath()
        
        let cloudLayer = CAShapeLayer()
        cloudLayer.path = path.cgPath
        
        cloudLayer.lineWidth = 1
        cloudLayer.strokeColor = UIColor.black.cgColor
        cloudLayer.fillColor = UIColor.clear.cgColor
        
        let cloudBlueLayer = CAShapeLayer()
        cloudBlueLayer.path = path.cgPath
        
        cloudBlueLayer.lineWidth = 2
        cloudBlueLayer.strokeColor = UIColor.white.cgColor
        cloudBlueLayer.fillColor = UIColor.clear.cgColor
        
        cloudLayer.addSublayer(cloudBlueLayer)
        self.layer.addSublayer(cloudLayer)
        
        
        // add circle
        let circleLayer = CAShapeLayer()
        circleLayer.backgroundColor = UIColor.white.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        //circleLayer.position = CGPoint(x: 110.89, y: 99.2)
        circleLayer.cornerRadius = circleLayer.bounds.height / 2
        //circleLayer.masksToBounds = true

        self.layer.addSublayer(circleLayer)
        
        
        // animations
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.duration = 2
        strokeStartAnimation.autoreverses = true
        strokeStartAnimation.repeatCount = .infinity
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 2
        strokeEndAnimation.autoreverses = true
        strokeEndAnimation.repeatCount = .infinity
        
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = path.cgPath
        followPathAnimation.calculationMode = CAAnimationCalculationMode.paced
        followPathAnimation.duration = 2
        followPathAnimation.autoreverses = true
        followPathAnimation.repeatCount = .infinity
        
        let group = CAAnimationGroup()
        group.animations = [strokeEndAnimation, strokeStartAnimation]
        group.duration = 4
        group.autoreverses = true
        group.repeatCount = .infinity

        
        
        
        circleLayer.add(followPathAnimation, forKey: nil)
        cloudBlueLayer.add(group, forKey: nil)
        cloudLayer.add(strokeEndAnimation, forKey: nil)
        
        
        
        

    }
    
    
    private func makeCloudPath() -> UIBezierPath {
        //let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)

        
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 103.55, y: 37.36))
        bezierPath.addCurve(to: CGPoint(x: 104.8, y: 27.16), controlPoint1: CGPoint(x: 104.59, y: 34.08), controlPoint2: CGPoint(x: 105.01, y: 30.66))
        bezierPath.addCurve(to: CGPoint(x: 75.84, y: 0.18), controlPoint1: CGPoint(x: 103.9, y: 12.4), controlPoint2: CGPoint(x: 90.91, y: 0.3))
        bezierPath.addCurve(to: CGPoint(x: 75.61, y: 0.18), controlPoint1: CGPoint(x: 75.76, y: 0.18), controlPoint2: CGPoint(x: 75.69, y: 0.18))
        bezierPath.addCurve(to: CGPoint(x: 48.31, y: 18.6), controlPoint1: CGPoint(x: 63.45, y: 0.18), controlPoint2: CGPoint(x: 52.6, y: 7.69))
        bezierPath.addCurve(to: CGPoint(x: 32.22, y: 13.83), controlPoint1: CGPoint(x: 43.85, y: 15.03), controlPoint2: CGPoint(x: 38.09, y: 13.28))
        bezierPath.addCurve(to: CGPoint(x: 13.68, y: 28.2), controlPoint1: CGPoint(x: 23.88, y: 14.62), controlPoint2: CGPoint(x: 16.6, y: 20.26))
        bezierPath.addCurve(to: CGPoint(x: 12.68, y: 38.94), controlPoint1: CGPoint(x: 12.38, y: 31.71), controlPoint2: CGPoint(x: 12.05, y: 35.31))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 58.78), controlPoint1: CGPoint(x: 5.01, y: 42.59), controlPoint2: CGPoint(x: 0, y: 50.3))
        bezierPath.addCurve(to: CGPoint(x: 22.62, y: 83.44), controlPoint1: CGPoint(x: 0, y: 70.69), controlPoint2: CGPoint(x: 9.09, y: 83.44))
        bezierPath.addLine(to: CGPoint(x: 91.69, y: 83.44))
        bezierPath.addCurve(to: CGPoint(x: 120.62, y: 58.78), controlPoint1: CGPoint(x: 113.02, y: 83.44), controlPoint2: CGPoint(x: 120.62, y: 70.7))
        bezierPath.addCurve(to: CGPoint(x: 103.55, y: 37.36), controlPoint1: CGPoint(x: 120.62, y: 48.44), controlPoint2: CGPoint(x: 113.48, y: 39.73))
        bezierPath.close()


        bezierPath.move(to: CGPoint(x: 40.04, y: 36.62))
        bezierPath.addCurve(to: CGPoint(x: 30.15, y: 47), controlPoint1: CGPoint(x: 34.59, y: 36.62), controlPoint2: CGPoint(x: 30.15, y: 41.28))
        bezierPath.addLine(to: CGPoint(x: 35.1, y: 47))
        bezierPath.addCurve(to: CGPoint(x: 40.04, y: 41.81), controlPoint1: CGPoint(x: 35.1, y: 44.14), controlPoint2: CGPoint(x: 37.31, y: 41.81))
        bezierPath.addCurve(to: CGPoint(x: 44.98, y: 47), controlPoint1: CGPoint(x: 42.76, y: 41.81), controlPoint2: CGPoint(x: 44.98, y: 44.14))
        bezierPath.addLine(to: CGPoint(x: 49.92, y: 47))
        bezierPath.addCurve(to: CGPoint(x: 40.04, y: 36.62), controlPoint1: CGPoint(x: 49.92, y: 41.28), controlPoint2: CGPoint(x: 45.49, y: 36.62))
        bezierPath.close()
 
        
        
  
        bezierPath.move(to: CGPoint(x: 75.38, y: 36.62))
        bezierPath.addCurve(to: CGPoint(x: 65, y: 47), controlPoint1: CGPoint(x: 69.66, y: 36.62), controlPoint2: CGPoint(x: 65, y: 41.28))
        bezierPath.addLine(to: CGPoint(x: 70.19, y: 47))
        bezierPath.addCurve(to: CGPoint(x: 75.38, y: 41.81), controlPoint1: CGPoint(x: 70.19, y: 44.14), controlPoint2: CGPoint(x: 72.52, y: 41.81))
        bezierPath.addCurve(to: CGPoint(x: 80.58, y: 47), controlPoint1: CGPoint(x: 78.25, y: 41.81), controlPoint2: CGPoint(x: 80.58, y: 44.14))
        bezierPath.addLine(to: CGPoint(x: 85.77, y: 47))
        bezierPath.addCurve(to: CGPoint(x: 75.38, y: 36.62), controlPoint1: CGPoint(x: 85.77, y: 41.28), controlPoint2: CGPoint(x: 81.11, y: 36.62))
        bezierPath.close()
        

        bezierPath.move(to: CGPoint(x: 80.71, y: 57.39))
        bezierPath.addCurve(to: CGPoint(x: 57.96, y: 65.45), controlPoint1: CGPoint(x: 80.71, y: 60.75), controlPoint2: CGPoint(x: 72.06, y: 65.45))
        bezierPath.addCurve(to: CGPoint(x: 35.21, y: 57.39), controlPoint1: CGPoint(x: 43.87, y: 65.45), controlPoint2: CGPoint(x: 35.21, y: 60.75))
        bezierPath.addLine(to: CGPoint(x: 30.15, y: 57.39))
        bezierPath.addCurve(to: CGPoint(x: 57.96, y: 70.36), controlPoint1: CGPoint(x: 30.15, y: 64.78), controlPoint2: CGPoint(x: 42.11, y: 70.36))
        bezierPath.addCurve(to: CGPoint(x: 85.77, y: 57.39), controlPoint1: CGPoint(x: 73.82, y: 70.36), controlPoint2: CGPoint(x: 85.77, y: 64.78))
        bezierPath.addLine(to: CGPoint(x: 80.71, y: 57.39))
        bezierPath.close()

        
        return bezierPath
    }
    
    
    
    
    
}
