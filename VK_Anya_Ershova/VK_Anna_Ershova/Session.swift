//
//  Session.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/4/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation


class Session {
    
    private init() {
        
    }
    
    public static let shared = Session()
    
    var userId: Int = 0
    var token: String = ""
    
     
}
