//
//  Group.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/12/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group : Decodable, CustomStringConvertible {
    var description: String {
        return " The group name is \(name)"
    }
    
    var id = 0
    var name = ""
    var photo = ""
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case photo
        
    }
    
    init(json: JSON)  {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_100"].stringValue
        
    }
}

class GlobalGroup: Decodable, CustomStringConvertible {
    var description: String {
        return " The group name is \(name)"
    }
    
    var id = 0
    var name = ""
    var photo = ""
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case photo
        
    }
    
    init(json: JSON)  {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_100"].stringValue
        
    }
}

