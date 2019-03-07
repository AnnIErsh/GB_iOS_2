//
//  GroupCell.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 28/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var imageGr: UIImageView!
    @IBOutlet weak var grdName: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        grdName.text = nil
        imageGr.image = nil
    }

    func configure(friend: String, img: UIImage) {
        grdName.text = friend
        imageGr.image = img
    }
    
    func configured(with group: Group) {
        
        let name = group.name
        grdName.text = name
        
        let img = group.photo
        imageGr.kf.setImage(with: URL(string: img))
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
