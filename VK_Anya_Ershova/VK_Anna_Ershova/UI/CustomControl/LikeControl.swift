//
//  LikeControl.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 08/01/2019.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIControl {
    
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        return button
    }()
    
    //the number of likes
    private var like: Int = 21
    private lazy var likeCounter: UILabel = {
        let like = UILabel()
        like.textColor = UIColor.lightGray
        like.textAlignment = .left
        like.font = UIFont.systemFont(ofSize: 16)
        return like
    }()
    
    private var isLiked = false
    
    private var likeView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 25.0))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    
    // Empty Heart
    private var image: UIImage? = {
        
        let rect = CGRect(x: 0, y: 0, width: 22.0, height: 22.0)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            UIGraphicsPushContext(context)
        }
        UIGraphicsBeginImageContext(rect.size)
        
        let bezier = UIBezierPath(heartIn: rect)
        
        bezier.lineWidth = 2.0
        bezier.lineJoinStyle = .bevel
        UIColor.lightGray.setStroke()
        bezier.stroke()
        context?.addPath(bezier.cgPath)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsPopContext()
        UIGraphicsEndImageContext()
        return image
        
    }()
    // Filled Heart
    private var imageLiked: UIImage? = {
        
        let rect = CGRect(x: 0, y: 0, width: 22.0, height: 22.0)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            UIGraphicsPushContext(context)
        }
        UIGraphicsBeginImageContext(rect.size)
        
        let bezier = UIBezierPath(heartIn: rect)
        
        bezier.lineWidth = 2.0
        bezier.lineJoinStyle = .bevel
        UIColor.red.setFill()
        bezier.fill()
        context?.addPath(bezier.cgPath)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsPopContext()
        UIGraphicsEndImageContext()
        return image
    }()
    
    
    
    private func setupView() {
        
        likeCounter.text = String(like)
        likeButton.setImage(isLiked == true ? imageLiked : image, for: .normal)
        likeButton.addTarget(self, action: #selector(toLike), for: .touchUpInside)
        likeView.addGestureRecognizer(recognizer)
        
        
        self.addSubview(likeView)
        self.likeView.addSubview(likeButton)
        self.likeView.addSubview(likeCounter)
        likeView.backgroundColor = nil
        
        
    }
    
    lazy var recognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(toLike))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    
    @objc func toLike() {
        
        if !isLiked {
            isLiked = true
            likeCounter.textColor = UIColor.black
            like += 1
            
            
            let rotationLike = CABasicAnimation(keyPath: "transform.rotation")
            rotationLike.fromValue = 0.0
            rotationLike.toValue = CGFloat(Double.pi * 2)
            rotationLike.duration = 0.2
            likeButton.layer.add(rotationLike, forKey: nil)
            
            let likeScale = CASpringAnimation(keyPath: "transform.scale")
            likeScale.fromValue = 0.7
            likeScale.toValue = 1
            likeScale.stiffness = 200
            likeScale.mass = 1
            likeScale.duration = 0.3
            likeScale.beginTime = CACurrentMediaTime()
            likeScale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            likeScale.fillMode = CAMediaTimingFillMode.both
            likeCounter.layer.add(likeScale, forKey: nil)
            likeButton.layer.add(likeScale, forKey: nil)
            
            //            UIView.animate(withDuration: 1, animations: { () -> Void in
            //
            //                self.likeButton.transform = self.likeButton.transform.rotated(by: CGFloat(Double.pi))
            //
            //            })
            
            
            
        } else {
            isLiked = false
            likeCounter.textColor = UIColor.lightGray
            like -= 1
        }
        
        
        
        self.setupView()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        likeView.frame = bounds
        likeButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        likeCounter.frame = CGRect(x: 27.5, y: 0, width: 40, height: 25)
        
        
        //        let rotate = CGAffineTransform(rotationAngle: 360)
        //        let scale = CGAffineTransform(scaleX: 5, y: 5)
        
        
        
        
        
    }
    
}
//Heart drawing
extension UIBezierPath {
    
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        //Radius
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
        
        //Left
        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        //Top
        self.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        
        //Right
        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        //Right Bottom
        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        
        //Left Bottom
        self.close()
    }
}
extension Int {
    
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
    
}



//    func drawHeart() -> UIImage? {
//        let rect = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
//        let context = UIGraphicsGetCurrentContext()
//        if let context = context {
//            UIGraphicsPushContext(context)
//        }
//        UIGraphicsBeginImageContext(rect.size)
//
//        let bezier = UIBezierPath(heartIn: self.bounds)
//
//        bezier.lineWidth = 3.0
//        bezier.lineJoinStyle = .bevel
//        bezier.stroke()
//        context?.addPath(bezier.cgPath)
//        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsPopContext()
//        UIGraphicsEndImageContext()
//        return image
//    }

