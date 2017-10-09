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
    
    func post(username: String, password:String) {
        //post
        //        let parameters = ["username":"admin","password":"dtapi_admin"]
        let parameters = ["username":username,"password":password]
        
        var request = URLRequest(url: URL(string: url + urlLogIn)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let sessionPost = URLSession.shared
        sessionPost.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
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
