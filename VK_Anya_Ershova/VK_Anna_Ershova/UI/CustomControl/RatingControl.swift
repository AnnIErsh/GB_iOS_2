//
//  RatingControl.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/15/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit


@IBDesignable class RatingControl: UIStackView {
    
    
    private var ratingButtons = [UIButton]()
    var rating: Int = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    var heartCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        isUserInteractionEnabled = true
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<heartCount {
            
            let button = UIButton()
            button.backgroundColor = nil
            
            button.setImage(imageEmpty, for: .normal)
            button.setImage(imageFill, for: .selected)
            addArrangedSubview(button)
            
            ratingButtons.append(button)
            
        }
        
        updateButtonSelectionStates()
        
        
        
        let press = UILongPressGestureRecognizer(target: self, action: #selector(handleSelection(_ :)))
        press.minimumPressDuration = 0.1
        addGestureRecognizer(press)
        
    }
    
    
    @objc func handleSelection(_ press: UILongPressGestureRecognizer) {
        
        let location = press.location(in: self.superview)
        
        detectWhichHeart(location: location)
        
    }
    
    func  detectWhichHeart (location: CGPoint) {
        for (index, button) in ratingButtons.enumerated() {
            
            let frame = button.convert(button.bounds, to: self.superview)
            if frame.contains(location) {
                rating = index + 1
            }
        }
    }
    
    
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
        }
    }
    
    
    // Empty Heart
    private var imageEmpty: UIImage? = {
        
        let rect = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
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
    private var imageFill: UIImage? = {
        
        let rect = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
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
    
}
