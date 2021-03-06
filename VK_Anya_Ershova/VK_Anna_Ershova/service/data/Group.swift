//
//  Group.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/12/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Group : Object {
    override var description: String {
        return " The group name is \(name)"
    }
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var photo = ""
    dynamic var isMember = 0
    
    
    required convenience init (json: JSON)  {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_100"].stringValue
        self.isMember = json["is_member"].intValue
        
    }
    
    
    var toAnyObject: Any {
        return [
            "name": name,
            "photo": photo,
            "id": id
            //"member": isMember
        ]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


