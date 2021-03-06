//
//  VKService.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/7/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService {
    public static let vk = VKService()
    static let sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40
        let sessionManager = SessionManager(configuration: config)
        
        return sessionManager
    }()
    var sessionUserId = Session.shared.userId
    var sessionToken = Session.shared.token
    let url = "https://api.vk.com"
    let realmProvider = RealmProvider()
    
    
    
    func loadFriends(completion: (([User]?, Error?) -> Void)? = nil) {
        
        let path = "/method/friends.get"
        let params: Parameters = [
            //"count": 3,
            "access_token" : sessionToken,
            "fields" : "photo_100",
            "v": "5.92",
            "order" : "name"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let users = json["response"]["items"].arrayValue.map { User(json: $0) }
                
                //self.realmProvider.save(items: users)
                
                completion?(users, nil)
                //print("____________ Get Friends ____________: \(value) -----------")
                //users.forEach{print($0)}
            }
        }
        
    }
    func searchFriends(isSearching: String ,completion: (([User]?, Error?) -> Void)? = nil) {
        
        let path = "/method/friends.search"
        let params: Parameters = [
            //"count": 3,
            "access_token" : sessionToken,
            "q" : isSearching,
            "v": "5.92",
            //"order" : "name"
            "fields" : "photo_100"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let users = json["response"]["items"].arrayValue.map { User(json: $0) }
                completion?(users, nil)
                //print("____________ Search Friends ____________: \(value) -----------")
                //users.forEach{print($0)}
            }
        }
        
    }
    
    
    
    
    func loadGroups(completion: (([Group]?, Error?) -> Void)? = nil) {
        
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : sessionToken,
            //"count": 10,
            "extended" : 1,
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON  { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                
                self.realmProvider.save(items: groups)
                
                completion?(groups, nil)
                //print("____________ Get Groups ____________: \(value) -----------")
                //groups.forEach{print($0)}
            }
        }
    }
    
    func searchGroups(isSearching: String, completion: (([Group]?, Error?) -> Void)? = nil) {
        let path = "/method/groups.search"
        let params: Parameters = [
            "count": 30,
            "access_token" : sessionToken,
            "extended" : 1,
            "q": isSearching,
            "v": "5.92"
        ]
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON  { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                completion?(groups, nil)
                //print("____________ Search Groups ____________: \(value) -----------")
                //groups.forEach{print($0)}
            }
        }
    }
    
    func leftGroups(for group_id: Int, completion: (([Group]?, Error?) -> Void)? = nil) {
        let path = "/method/groups.leave"
        let params: Parameters = [
            //"count": 30,
            "access_token" : sessionToken,
            "group_id" : group_id,
            "v": "5.92"
        ]
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON  { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                completion?(groups, nil)
                //print("____________ Left Groups ____________: \(value) -----------")
                //groups.forEach{print($0)}
            }
        }
    }
    func addGroups(groupId: Int, completion: (([Group]?, Error?) -> Void)? = nil) {
        let path = "/method/groups.join"
        let params: Parameters = [
            //"count": 30,
            "access_token" : sessionToken,
            "group_id" : groupId,
            "v": "5.92"
        ]
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON  { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
                completion?(groups, nil)
                //print("____________ Join Groups ____________: \(value) -----------")
                //groups.forEach{print($0)}
            }
        }
    }
    
    
    func loadPhoto(photoOwnerId: Int, completion: (([Photo]?, Error?) -> Void)? = nil) {
        var photos = [Photo]()
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token" : sessionToken,
            "owner_id" : photoOwnerId,
            //"album_id" : "profile",
            "count": 10,
            "extended" : 1,
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                photos = json["response"]["items"].arrayValue.map { Photo(json: $0) }.filter { !$0.photoURL.isEmpty }
                for photo in photos {
                    photo.photoId = photoOwnerId
                }
                
                //self.realmProvider.save(items: photos)
                
                
                completion?(photos, nil)
                //print("____________ Get Photos ____________: \(value) -----------")
                //photos.forEach{print($0)}
            }
        }
    }
    
    
    
}
