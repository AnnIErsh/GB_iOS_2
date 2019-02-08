//
//  VKService.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/7/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import Foundation
import Alamofire

class VKService {
    static let sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40
        let sessionManager = SessionManager(configuration: config)
        
        return sessionManager
    }()
    
    var sessionToken = Session.shared.token
    let url = "https://api.vk.com"
    
    
    func loadFriends() {
        
        let path = "/method/friends.get"
        let params: Parameters = [
            "count": 5,
            "access_token" : sessionToken,
            "fields" : "nickname, domain, sex",
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            
            print("____________ Get friends ____________: \(value) -----------")
        }
    }
    
    
    
    func loadGroups() {
        
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : sessionToken,
            "count": 5,
            "extended" : 1,
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            
            print("____________ Get Groups ____________: \(value) -----------")
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
    
    func loadPhoto() {
        
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token" : sessionToken,
            //"owner_id" : sessionToken,
            //"album_id" : "profile",
            "count": 5,
            "extended" : 1,
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            
            print("____________ Loading Photos ____________: \(value) -----------")
        }
    }
    
    
    func loadPhotoById(_ ownerId: Int) {
        let path = "/method/photos.get"
        let params: Parameters = [
            "access_token" : sessionToken,
            "owner_id" : "\(ownerId)",
            "album_id" : "profile",
            "count": 5,
            "extended" : 1,
            "v": "5.92"
        ]
        
        Alamofire.request(url+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            
            print("____________ Loading Photos by ID ____________: \(value) -----------")
        }
    }
}
