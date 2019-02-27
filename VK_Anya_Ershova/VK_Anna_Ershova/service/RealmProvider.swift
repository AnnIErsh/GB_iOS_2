//
//  RealmProvider.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/25/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {
    
    func save<T: Object>(items: [T],
                         config: Realm.Configuration = Realm.Configuration.defaultConfiguration,
                         update: Bool = true) {
        print("--------------Realm data file--------------: ", config.fileURL!)
        
        do {
            let realm = try Realm(configuration: config)
            let oldItems = realm.objects(T.self)
            
            try realm.write {
                
                realm.delete(oldItems)
                realm.add(items, update: update)
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func saveItems<T: Object>(items: [T],
                                     config: Realm.Configuration = Realm.Configuration.defaultConfiguration,
                                     update: Bool = true) {
        print("Realm data file: ", config.fileURL!)
        
        do {
            let realm = try Realm(configuration: config)
            
            
            try realm.write {
                
                
                realm.add(items, update: update)
            }
            
            
        } catch {
            print(error)
        }
    }
    
}
