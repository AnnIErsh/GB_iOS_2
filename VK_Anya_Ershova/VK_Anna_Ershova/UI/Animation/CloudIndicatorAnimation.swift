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
//        bezierPath.move(to: CGPoint(x: 91.69, y: 78.35))
//        bezierPath.addLine(to: CGPoint(x: 22.62, y: 78.35))
//        bezierPath.addCurve(to: CGPoint(x: 5.03, y: 58.78), controlPoint1: CGPoint(x: 12.25, y: 78.35), controlPoint2: CGPoint(x: 5.03, y: 68.04))
//        bezierPath.addCurve(to: CGPoint(x: 16.45, y: 42.87), controlPoint1: CGPoint(x: 5.03, y: 51.71), controlPoint2: CGPoint(x: 9.62, y: 45.31))
//        bezierPath.addLine(to: CGPoint(x: 18.67, y: 42.07))
//        bezierPath.addLine(to: CGPoint(x: 18.03, y: 39.77))
//        bezierPath.addCurve(to: CGPoint(x: 18.39, y: 29.97), controlPoint1: CGPoint(x: 17.09, y: 36.46), controlPoint2: CGPoint(x: 17.21, y: 33.16))
//        bezierPath.addCurve(to: CGPoint(x: 32.69, y: 18.9), controlPoint1: CGPoint(x: 20.64, y: 23.86), controlPoint2: CGPoint(x: 26.26, y: 19.51))
//        bezierPath.addCurve(to: CGPoint(x: 34.37, y: 18.82), controlPoint1: CGPoint(x: 33.25, y: 18.84), controlPoint2: CGPoint(x: 33.81, y: 18.82))
//        bezierPath.addCurve(to: CGPoint(x: 47.58, y: 24.93), controlPoint1: CGPoint(x: 39.48, y: 18.82), controlPoint2: CGPoint(x: 44.33, y: 21.03))
//        bezierPath.addLine(to: CGPoint(x: 50.84, y: 28.82))
//        bezierPath.addLine(to: CGPoint(x: 51.95, y: 23.84))
//        bezierPath.addCurve(to: CGPoint(x: 75.61, y: 5.27), controlPoint1: CGPoint(x: 54.37, y: 13.05), controlPoint2: CGPoint(x: 64.3, y: 5.27))
//        bezierPath.addCurve(to: CGPoint(x: 75.8, y: 5.27), controlPoint1: CGPoint(x: 75.67, y: 5.27), controlPoint2: CGPoint(x: 75.74, y: 5.27))
//        bezierPath.addCurve(to: CGPoint(x: 99.78, y: 27.48), controlPoint1: CGPoint(x: 88.29, y: 5.37), controlPoint2: CGPoint(x: 99.04, y: 15.33))
//        bezierPath.addCurve(to: CGPoint(x: 97.81, y: 38.32), controlPoint1: CGPoint(x: 100.01, y: 31.23), controlPoint2: CGPoint(x: 99.35, y: 34.88))
//        bezierPath.addLine(to: CGPoint(x: 96.36, y: 41.57))
//        bezierPath.addLine(to: CGPoint(x: 99.87, y: 41.9))
//        bezierPath.addCurve(to: CGPoint(x: 115.59, y: 58.78), controlPoint1: CGPoint(x: 108.83, y: 42.74), controlPoint2: CGPoint(x: 115.59, y: 50))
//        bezierPath.addCurve(to: CGPoint(x: 91.69, y: 78.35), controlPoint1: CGPoint(x: 115.59, y: 64.66), controlPoint2: CGPoint(x: 113.26, y: 78.35))
//        bezierPath.close()

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
        //fillColor.setFill()
        //bezierPath.fill()
        
        
//        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 80.62, y: 8))
//        bezierPath.addCurve(to: CGPoint(x: 104.81, y: 31.7), controlPoint1: CGPoint(x: 93.87, y: 8), controlPoint2: CGPoint(x: 104.66, y: 18.61))
//        bezierPath.addCurve(to: CGPoint(x: 104.69, y: 33.17), controlPoint1: CGPoint(x: 104.75, y: 32.19), controlPoint2: CGPoint(x: 104.7, y: 32.67))
//        bezierPath.addLine(to: CGPoint(x: 104.48, y: 39.05))
//        bezierPath.addLine(to: CGPoint(x: 110.09, y: 40.98))
//        bezierPath.addCurve(to: CGPoint(x: 120.94, y: 56), controlPoint1: CGPoint(x: 116.58, y: 43.23), controlPoint2: CGPoint(x: 120.94, y: 49.27))
//        bezierPath.addCurve(to: CGPoint(x: 104.81, y: 72), controlPoint1: CGPoint(x: 120.94, y: 64.83), controlPoint2: CGPoint(x: 113.71, y: 72))
//        bezierPath.addLine(to: CGPoint(x: 24.19, y: 72))
//        bezierPath.addCurve(to: CGPoint(x: 8.06, y: 56), controlPoint1: CGPoint(x: 15.3, y: 72), controlPoint2: CGPoint(x: 8.06, y: 64.83))
//        bezierPath.addCurve(to: CGPoint(x: 23.94, y: 40), controlPoint1: CGPoint(x: 8.06, y: 47.27), controlPoint2: CGPoint(x: 15.16, y: 40.14))
//        bezierPath.addCurve(to: CGPoint(x: 25.1, y: 40.13), controlPoint1: CGPoint(x: 24.31, y: 40.05), controlPoint2: CGPoint(x: 24.71, y: 40.1))
//        bezierPath.addLine(to: CGPoint(x: 31.23, y: 40.52))
//        bezierPath.addLine(to: CGPoint(x: 33.24, y: 34.78))
//        bezierPath.addCurve(to: CGPoint(x: 48.38, y: 24), controlPoint1: CGPoint(x: 35.51, y: 28.33), controlPoint2: CGPoint(x: 41.59, y: 24))
//        bezierPath.addCurve(to: CGPoint(x: 51.19, y: 24.3), controlPoint1: CGPoint(x: 49.16, y: 24), controlPoint2: CGPoint(x: 50.03, y: 24.09))
//        bezierPath.addLine(to: CGPoint(x: 56.84, y: 25.3))
//        bezierPath.addLine(to: CGPoint(x: 59.65, y: 20.34))
//        bezierPath.addCurve(to: CGPoint(x: 80.62, y: 8), controlPoint1: CGPoint(x: 63.96, y: 12.73), controlPoint2: CGPoint(x: 72, y: 8))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 80.62, y: 0))
//        bezierPath.addCurve(to: CGPoint(x: 52.62, y: 16.42), controlPoint1: CGPoint(x: 68.55, y: 0), controlPoint2: CGPoint(x: 58.15, y: 6.67))
//        bezierPath.addCurve(to: CGPoint(x: 48.38, y: 16), controlPoint1: CGPoint(x: 51.24, y: 16.18), controlPoint2: CGPoint(x: 49.83, y: 16))
//        bezierPath.addCurve(to: CGPoint(x: 25.63, y: 32.14), controlPoint1: CGPoint(x: 37.81, y: 16), controlPoint2: CGPoint(x: 28.92, y: 22.77))
//        bezierPath.addCurve(to: CGPoint(x: 24.19, y: 32), controlPoint1: CGPoint(x: 25.15, y: 32.11), controlPoint2: CGPoint(x: 24.68, y: 32))
//        bezierPath.addCurve(to: CGPoint(x: 0, y: 56), controlPoint1: CGPoint(x: 10.83, y: 32), controlPoint2: CGPoint(x: 0, y: 42.75))
//        bezierPath.addCurve(to: CGPoint(x: 24.19, y: 80), controlPoint1: CGPoint(x: 0, y: 69.25), controlPoint2: CGPoint(x: 10.83, y: 80))
//        bezierPath.addLine(to: CGPoint(x: 104.81, y: 80))
//        bezierPath.addCurve(to: CGPoint(x: 129, y: 56), controlPoint1: CGPoint(x: 118.17, y: 80), controlPoint2: CGPoint(x: 129, y: 69.25))
//        bezierPath.addCurve(to: CGPoint(x: 112.73, y: 33.42), controlPoint1: CGPoint(x: 129, y: 45.52), controlPoint2: CGPoint(x: 122.18, y: 36.69))
//        bezierPath.addCurve(to: CGPoint(x: 112.88, y: 32), controlPoint1: CGPoint(x: 112.75, y: 32.94), controlPoint2: CGPoint(x: 112.88, y: 32.48))
//        bezierPath.addCurve(to: CGPoint(x: 80.62, y: 0), controlPoint1: CGPoint(x: 112.88, y: 14.33), controlPoint2: CGPoint(x: 98.44, y: 0))
//        bezierPath.addLine(to: CGPoint(x: 80.62, y: 0))
//        bezierPath.close()
//        fillColor.setFill()
//        bezierPath.fill()
        
        return bezierPath
    }
    
    
    
    
    
}
