//
//  Photo.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/12/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo : CustomStringConvertible {
    var description: String {
        return " The photos are \(photoURL) "
    }
    var id = 0
    var photoURL : String

    init(json: JSON)  {
        self.id = json["id"].intValue
        self.photoURL = json["sizes"][8]["url"].stringValue
    }
}
