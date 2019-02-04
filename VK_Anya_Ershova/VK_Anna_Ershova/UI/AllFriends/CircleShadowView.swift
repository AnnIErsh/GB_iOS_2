//
//  CircleShadowView.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 08/01/2019.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class CircleShadowView: UIImageView {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        
    }
    
}

/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */


