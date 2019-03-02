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
        print("--------------Realm data file--------------: ", config.fileURL!)
        
        do {
            let realm = try Realm(configuration: config)
            
            
            try realm.write {
                
                
                realm.add(items, update: update)
            }
            
            
        } catch {
            print(error)
        }
    }
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func get<T: Object>(_ type: T.Type,
                               config: Realm.Configuration = Realm.Configuration.defaultConfiguration)
        throws -> Results<T> {
            let realm = try Realm(configuration: self.deleteIfMigration)
            return realm.objects(type)
    }
    
    static func delete<T: Object>(_ items: [T],
                                  config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        let realm = try? Realm(configuration: self.deleteIfMigration)
        try? realm?.write {
            realm?.delete(items)
        }
    }
    
}


extension IndexPath {
    static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

extension UITableView {
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        beginUpdates()
        deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
        insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
        reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
        endUpdates()
    }
}
