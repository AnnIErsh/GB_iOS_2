//
//  FirebaseVK.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 3/6/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseVK {
    let ref: DatabaseReference?
    let uid: String
    let uidInt: Int
    
    init(uid: String, uidInt: Int) {
        self.ref = nil
        self.uid = uid
        self.uidInt = uidInt
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
            let uid = value["uid"] as? String,
            let uidInt = value["uidInt"] as? Int else { return nil }
        
        self.ref = snapshot.ref
        self.uid = uid
        self.uidInt = uidInt
        
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "uid": uid,
            "uidInt": uidInt
        ]
    }
    
    
    //    func toAnyObject() -> [String: Any] {
    //        return [
    //            "userId": uid,
    //            "vkUserId": vkUserId
    //        ]
    //    }
    
//    static func addLoggedToFirebaseDatabase(_ user: User) {
//        let dataRef = Database.database().reference()
//        dataRef.child("Users").child("\(user.id)").setValue(user.toAnyObject)
//    }
//
//    static func addGroup(user: String, groups: [Group]){
//        let dataRef = Database.database().reference()
//        dataRef.child("Users").child(user).updateChildValues(["groups":groups.map{$0.toAnyObject}])
//    }
    
    static func checkedGroups (group: Group) {
        let ref = Database.database().reference()
        ref.child("\(Session.shared.token)/addGroups").updateChildValues([String(group.id): group.name])
    }
    
    static func searchStory (searchText: String) {
        let ref = Database.database().reference()
        ref.child("\(Session.shared.token)/lookGroupStory").updateChildValues([String(format: "%0.f", Date().timeIntervalSinceReferenceDate): searchText])
    }
    
}

//    static func addedGroup(user:String, groups: [Group]){
//        let dbLink = Database.database().reference()
//        dbLink.child("UsersData").updateChildValues(["user":user,"groups":groups.map{$0.toAnyObject}])
//        dbLink.child("UsersData").child(user).updateChildValues(["groups":groups.map{$0.toAnyObject}])
//    }

