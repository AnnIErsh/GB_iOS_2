//
//  AllGroupCell.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 28/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit

class AllGroupCell: UITableViewCell {
    @IBOutlet weak var imageAllGr: UIImageView!
    @IBOutlet weak var grdAllName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        grdAllName.text = nil
        imageAllGr.image = nil
    }
    
    func configure(friend: String, img: UIImage) {
        grdAllName.text = friend
        imageAllGr.image = img
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
