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

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    //let lastname: String
    override var description: String {
        return "My friend is \(id) \(name) \(avatar)"
    }
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    
    
    
    
    //    enum CodingKeys: String, CodingKey {
    //        case id
    //        case name
    //        case avatar
    //
    //
    //        case firstname
    //        case lastname
    //
    //
    //    }
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue + " " + json["last_name"].stringValue
        self.avatar = json["photo_100"].stringValue
        
        
        self.firstname = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        
        
    }
    
}
