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
    
    public static var shared = Session()
    
    var token: Int = 0
    var userId: String = ""
    
    
}
