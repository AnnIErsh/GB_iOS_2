//
//  Photo.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/12/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import Kingfisher

@objcMembers
class Photo : Object {
    override var description: String {
        return " The photos are \(photoURL) "
    }
    dynamic var id = 0
    dynamic var photoId = 0
    dynamic var photoURL : String = ""
    dynamic var stringId: String = ""
    
    required convenience init (json: JSON)  {
        self.init()
        self.id = json["id"].intValue
        self.photoURL = json["sizes"][8]["url"].stringValue
        self.stringId = json["owner_id"].stringValue
    }
    override static func primaryKey() -> String {
        return "id"
    }
}
