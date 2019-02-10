//
//  LoginVkViewController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 2/7/19.
//  Copyright © 2019 Anna Ershova. All rights reserved.
//

import UIKit
import WebKit
import Alamofire


class LoginVkViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    //var sessionToken = Session.shared.token
        
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6850892"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
        
        //var sessionToken = Session.shared.token
        


    }
    
    
}
extension LoginVkViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        


        print(params)
        
        
        guard let token = params["access_token"], let userId = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }


        Session.shared.token = token
        Session.shared.userId = userId
        print(token, userId)
        //loadGroups()
        performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
        //print("my token after: ", sessionToken)
        //Session.shared.printTokenSession()
        

    }
    
    
    

    
}
