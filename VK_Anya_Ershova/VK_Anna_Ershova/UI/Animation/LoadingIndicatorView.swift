//
//  LoadingIndicatorView.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/24/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    // array with dots
    private var dotLayers = [CAShapeLayer]()
    private var dotsScale = 1.3
    
    //layer for dot
    private func dotLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.bounds = CGRect(origin: .zero, size: CGSize(width: dotsRadius * 2.0, height: dotsRadius * 2.0))
        layer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: dotsRadius).cgPath
        layer.fillColor = tintColor.cgColor
        return layer
    }
    
    
    private func setupLayers() {
        for _ in 0..<dotsCount {
            let layerDot = dotLayer()
            dotLayers.append(layerDot)
            layer.addSublayer(layerDot)
        }
    }
    
    @IBInspectable public var dotsCount: Int = 3 {
        didSet {
            layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            dotLayers.removeAll()
            setupLayers()
        }
    }
    
    @IBInspectable public var dotsRadius: CGFloat = 6.0 {
        didSet {
            for layer in dotLayers {
                layer.bounds = CGRect(origin: .zero, size: CGSize(width: dotsRadius * 2.0, height: dotsRadius * 2.0))
                layer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: dotsRadius).cgPath
            }
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var dotsSpacing: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            for layer in dotLayers {
                layer.fillColor = tintColor.cgColor
            }
        }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupLayers()
    }
    
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let middle: Int = dotsCount / 2
        for (index, layer) in dotLayers.enumerated() {
            let x = center.x + CGFloat(index - middle) * ((dotsRadius * 2) + dotsSpacing)
            layer.position = CGPoint(x: x, y: center.y)
        }
        
        
        
        startAnimating()
        //        stopAnimating()
    }
    
    
    private func scaleAnimation(_ after: TimeInterval = 0) -> CAAnimationGroup {
        let scaleUp = CABasicAnimation(keyPath: "transform.scale")
        scaleUp.beginTime = after
        scaleUp.fromValue = 1
        scaleUp.toValue = dotsScale
        scaleUp.duration = 0.3
        scaleUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.beginTime = after + scaleUp.duration
        scaleDown.fromValue = dotsScale
        scaleDown.toValue = 1.0
        scaleDown.duration = 0.2
        scaleDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        
        let opacityUp = CABasicAnimation(keyPath: "opacity")
        opacityUp.beginTime = after
        opacityUp.fromValue = 1
        opacityUp.toValue = 0.1
        opacityUp.duration = 0.3
        opacityUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        
        
        let opacityDown = CABasicAnimation(keyPath: "opacity")
        opacityDown.beginTime = after + opacityUp.duration
        opacityDown.fromValue = 0.1
        opacityDown.toValue = 1
        opacityDown.duration = 0.2
        opacityDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        
        
        
        let group = CAAnimationGroup()
        group.animations = [scaleUp, opacityUp, scaleDown, opacityDown]
        //group.repeatCount = 4
        group.repeatCount = Float.infinity
        
        
        //        let animation = CABasicAnimation(keyPath: "opacity")
        //        animation.beginTime = CACurrentMediaTime() + 0.5
        //        animation.fromValue = 0.5
        //        animation.toValue = 0
        //        animation.duration = 10
        //        layer.add(animation, forKey: nil)
        //
        //
        //        let endGrop = CAAnimationGroup()
        //        endGrop.animations = [group, animation]
        //        endGrop.repeatCount = 1
        //        endGrop.duration = 10
        
        
        let sum = CGFloat(dotsCount) * 0.2 + CGFloat(0.4)
        group.duration = CFTimeInterval(sum)
        
        return group
    }
    
    
    
    public func startAnimating() {
        var offset :TimeInterval = 0.0
        dotLayers.forEach {
            $0.removeAllAnimations()
            $0.add(scaleAnimation(offset), forKey: nil)
            offset = offset + 0.25
            $0.repeatCount = 4
            
        }
        
    }
    
    
    public func stopAnimating() {
        
        let animation = CABasicAnimation(keyPath: "opacity")
        //        animation.beginTime = CACurrentMediaTime() + 0.5
        //        animation.fromValue = 0.5
        //        animation.toValue = 0
        //        animation.duration = 5
        animation.fillMode = CAMediaTimingFillMode.removed
        layer.add(animation, forKey: nil)
        
        
    }
}


//    let animation = CABasicAnimation(keyPath: "opacity")
//    animation.beginTime = CACurrentMediaTime() + 0.5
//    animation.fromValue = 0.5
//    animation.toValue = 0
//    animation.duration = 0.5
//    layer.add(animation, forKey: nil)

//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.beginTime = CACurrentMediaTime() + 0.5
//        animation.fromValue = 0.5
//        animation.toValue = 0
//        animation.duration = 5

//       layer.removeFromSuperlayer()
//        dotLayers.forEach { $0.add(animation, forKey: nil)}
//        dotLayers.forEach{$0.removeFromSuperlayer()}
