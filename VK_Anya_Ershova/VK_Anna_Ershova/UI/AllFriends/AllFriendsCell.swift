//
//  AllFriendsCell.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 26/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit

class AllFriendsCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var imageName: CircleShadowView! {
        didSet {
            imageName.layer.borderColor = UIColor.white.cgColor
            imageName.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var friendName: UILabel! {
        didSet {
            friendName.textColor = UIColor.black
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        friendName.text = nil
        imageName.image = nil
    }
    
    func configure(friend: String, img: UIImage) {
        friendName.text = friend
        imageName.image = img
    }
    
    
    // MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
