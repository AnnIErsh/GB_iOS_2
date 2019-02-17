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

class Group : Object {
    override var description: String {
        return " The group name is \(name)"
    }
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var isMember = 0
    
    //    enum CodingKeys: String, CodingKey {
    //
    //        case id
    //        case name
    //        case photo
    //        case isMember
    //
    //    }
    
    required convenience init (json: JSON)  {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_100"].stringValue
        self.isMember = json["is_member"].intValue
        
    }
}

//class GlobalGroup: Decodable, CustomStringConvertible {
//    var description: String {
//        return " The group name is \(name)"
//    }
//
//    var id = 0
//    var name = ""
//    var photo = ""
//
//    enum CodingKeys: String, CodingKey {
//
//        case id
//        case name
//        case photo
//
//    }
//
//    init(json: JSON)  {
//        self.id = json["id"].intValue
//        self.name = json["name"].stringValue
//        self.photo = json["photo_100"].stringValue
//
//    }
//}

