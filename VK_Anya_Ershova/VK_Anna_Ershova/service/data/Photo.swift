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

class Photo : Object {
    override var description: String {
        return " The photos are \(photoURL) "
    }
    @objc dynamic var id = 0
    @objc dynamic var photoURL : String = ""

    required convenience init (json: JSON)  {
        self.init()
        self.id = json["id"].intValue
        self.photoURL = json["sizes"][8]["url"].stringValue
    }
}
