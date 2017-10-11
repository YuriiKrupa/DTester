//
//  HTTPManager.swift
//  DTester
//
//  Created by ITA student on 10/9/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import Foundation

class HTTPManager {
    let url = "http://vps9615.hyperhost.name"
    let urlLogIn = "/login/index"
    let urlLogOut = "/login/logout"
    
    struct User: Decodable {
        var id: String
        var username: String
        var roles: [String]
        
        init(json: [String: Any]) {
            id = json["id"] as? String ?? "-1"
            username = json["username"] as? String ?? ""
            roles = json["roles"] as? [String] ?? [""]
        }
    }
    
    func post(username: String, password:String) -> User {
        //post
        //        let parameters = ["username":"admin","password":"dtapi_admin"]
        let parameters = ["username":username,"password":password]
        
        var uzver = User.init(json: ["username":"LOH"])
        
        var request = URLRequest(url: URL(string: url + urlLogIn)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
        
        let sessionPost = URLSession.shared
        sessionPost.dataTask(with: request) { (data, response, error) in
            if let response = response {
//                print("\n\nResponse",response)
            }
            
            guard let data = data else { return }
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print("DATA",json)
//                    How to return to main thread!!!!
                    uzver = try JSONDecoder().decode(User.self, from: data)
                    print(uzver)
                } catch {
                    print(error)
                }
            }.resume()
        return uzver
    }
    
    func get() {
        //GET
        let sessionGet = URLSession.shared
        sessionGet.dataTask(with: URL(string: url + urlLogOut)!) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
                
            }
            }.resume()
    }
    
}
