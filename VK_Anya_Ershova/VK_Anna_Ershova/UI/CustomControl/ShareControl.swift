//
//  ShareControl.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/21/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

@IBDesignable class ShareControl: UIControl {
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "share"), for: .normal)
        return button
    }()
    
    //the number of shares
    private var share: Int = 99
    private lazy var shareCounter: UILabel = {
        let share = UILabel()
        share.textColor = UIColor.lightGray
        share.textAlignment = .left
        share.font = UIFont.systemFont(ofSize: 16)
        return share
    }()
    
    private var isShared = false
    
    private var shareView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 25.0))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        
        shareCounter.text = String(share)
        shareButton.setImage(isShared == true ? UIImage(named: "shared") : UIImage(named: "share"), for: .normal)
        shareButton.addTarget(self, action: #selector(toShare), for: .touchUpInside)
        self.addSubview(shareView)
        self.shareView.addSubview(shareButton)
        self.shareView.addSubview(shareCounter)
        shareView.backgroundColor = UIColor.white
        shareView.addGestureRecognizer(recognizer)
        
        
    }
    
    
    lazy var recognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(toShare))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    
    @objc func toShare() {
        
        if !isShared {
            isShared = true
            shareCounter.textColor = UIColor.black
            share += 1
        } else {
            isShared = false
            shareCounter.textColor = UIColor.lightGray
            share -= 1
        }
        
        self.setupView()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shareView.frame = bounds
        shareButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        shareCounter.frame = CGRect(x: 27.5, y: 0, width: 40, height: 25)
        
        
    }
    
}



