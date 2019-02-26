//
//  User.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/11/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class User: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var avatar: String = ""
    //let lastname: String
    override var description: String {
        return "My friend is \(id) \(name) \(avatar)"
    }
    dynamic var firstname = ""
    dynamic var lastname = ""
    
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue + " " + json["last_name"].stringValue
        self.avatar = json["photo_100"].stringValue
        
        
        self.firstname = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        
        
    }
    override static func primaryKey() -> String {
        return "id"
    }
    
}
