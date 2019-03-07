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
    let photosForUser = LinkingObjects(fromType: User.self, property: "userPhotos")
    
    dynamic var id = 0
    dynamic var photoId = 0
    dynamic var photoURL : String = ""
    dynamic var stringId: String = ""
    dynamic var photoOwnerId: Int = 0
    
    required convenience init (json: JSON)  {
        self.init()
        self.id = json["id"].intValue
        self.photoURL = json["sizes"][8]["url"].stringValue
        self.stringId = json["id"].stringValue
        self.photoOwnerId = json["owner_id"].intValue
    }
    override static func primaryKey() -> String {
        return "stringId"
    }
}
