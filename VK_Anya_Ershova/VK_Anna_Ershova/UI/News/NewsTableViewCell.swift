//
//  NewsTableViewCell.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 1/21/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textNews: UILabel!
    
    @IBOutlet weak var imageNews: UIImageView!
    
    @IBOutlet weak var customStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
