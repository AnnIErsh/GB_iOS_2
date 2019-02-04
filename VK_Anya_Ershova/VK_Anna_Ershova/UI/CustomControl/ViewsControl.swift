//
//  ViewsControl.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/21/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

@IBDesignable class ViewsControl: UIControl {
    
    private var viewsImage = UIImage(named: "views")
    private var viewsImageView = UIImageView()
    
    private lazy var viewsCounter: UILabel = {
        let views = UILabel()
        views.textColor = UIColor.lightGray
        views.textAlignment = .left
        views.font = UIFont.systemFont(ofSize: 16)
        return views
    }()
    lazy var recognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(toView))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    //private var isViewed = false
    private var views: Int = 99
    
    private var viewsView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        
        viewsCounter.text = String(views)
        viewsImageView.image = viewsImage
        
        self.viewsView.addSubview(viewsCounter)
        viewsView = UIStackView(arrangedSubviews: [viewsImageView, viewsCounter ])
        viewsView.backgroundColor = nil
        viewsImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25.0)
        //viewsCounter.frame = CGRect(x: 27.5, y: 0, width: 40, height: 25)
        viewsView.distribution = .fillEqually
        self.addSubview(viewsView)
        addGestureRecognizer(recognizer)
        
    }
    @objc func toView() {
        views += 1
        
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewsView.frame = bounds
        //viewsImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        //viewsCounter.frame = CGRect(x: 27.5, y: 0, width: 40, height: 25)
        
        
    }
    
}
