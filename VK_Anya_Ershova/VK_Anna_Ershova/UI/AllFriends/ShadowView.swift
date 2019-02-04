//
//  ShadowView.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 08/01/2019.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            } else {
                self.removeShadow()
            }
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
        
    }
    @IBInspectable var shadowOpacity: Float{
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
        
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
        
    }
    
    fileprivate func addShadow() {
        //let imageView = UIImageView()
        
        
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: 67, height: 67)).self.layer
        layer.masksToBounds = false
        layer.shadowColor = self.shadowColor?.cgColor
        layer.shadowOffset = self.shadowOffset
        layer.shadowRadius = self.shadowRadius
        layer.shadowOpacity = self.shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let backgroundColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundColor
        
        
    }
    
    
    
    fileprivate func removeShadow() {
        
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
        let backgroundColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundColor
    }
    
    override func layoutSubviews() {
        
        
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    
}
