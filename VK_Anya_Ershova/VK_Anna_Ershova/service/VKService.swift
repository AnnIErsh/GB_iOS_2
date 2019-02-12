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

class VKService {
    static let sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40
        let sessionManager = SessionManager(configuration: config)
        
        return sessionManager
    }()
    
    var sessionToken = Session.shared.token
    let url = "https://api.vk.com"
    
    
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
                completion?(users, nil)
                print("____________ Get Friends ____________: \(value) -----------")
                users.forEach{print($0)}
            }
        }
        
    }
    
    
    
    
    func loadGroups(completion: (([Group]?, Error?) -> Void)? = nil) {
        
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : sessionToken,
            "count": 5,
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
                completion?(groups, nil)
                print("____________ Get Groups ____________: \(value) -----------")
                groups.forEach{print($0)}
            }
        }
    }
    
    func searchGroups(isSearching: String) {
        
        
        //let isSearching = "A"
        let path = "/method/groups.search"
        let params: Parameters = [
            "count": 5,
            "access_token" : sessionToken,
            "extended" : 1,
            "q": "\(isSearching)",
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            
            print("____________ Search Groups ____________: \(value) -----------")
        }
    }
    
    func loadPhoto(ownerId: Int, completion: (([Photo]?, Error?) -> Void)? = nil) {
        
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token" : sessionToken,
            "owner_id" : ownerId,
            //"album_id" : "profile",
            "count": 1,
            "extended" : 1,
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { repsonse in
            switch repsonse.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { Photo(json: $0) }
                completion?(photos, nil)
                print("____________ Get Photos ____________: \(value) -----------")
                photos.forEach{print($0)}
            }
        }
    }
    
    
    //    func loadPhotoById(_ ownerId: Int) {
    //        let path = "/method/photos.get"
    //        let params: Parameters = [
    //            "access_token" : sessionToken,
    //            "owner_id" : "\(ownerId)",
    //            "album_id" : "profile",
    //            "count": 5,
    //            "extended" : 1,
    //            "v": "5.92"
    //        ]
    //
    //        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { response in
    //            guard let value = response.value else { return }
    //
    //            print("____________ Loading Photos by ID ____________: \(value) -----------")
    //        }
    //    }
    
    
    
}
