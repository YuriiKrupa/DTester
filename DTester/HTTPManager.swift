//
//  HTTPManager.swift
//  DTester
//
//  Created by ITA student on 10/9/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import Foundation

class HTTPManager {
    let urlProtocol = "http://"
    let urlToHost = "vps9615.hyperhost.name"
    let urlUserLogIn = "/login/index"
    let urlUserLogOut = "/login/logout"
    let urlFaculties = "/faculty/getRecords"
    
    static func cooikiesGetter(_ hostUrl: String) -> [HTTPCookie] {
        let cookies:[HTTPCookie] = HTTPCookieStorage.shared.cookies! as [HTTPCookie]
//        for cookie:HTTPCookie in cookies as [HTTPCookie] {
//            if cookie.domain == hostUrl {
////                return cookie
//            }
//        }
        return cookies
    }
    
    func post(username: String, password:String, completionHandler: @escaping (_ responseUser: Entity.User, _ cookieVal: [HTTPCookie]) -> ()) {
        
        let parameters = ["username":username,"password":password]
        
        var request = URLRequest(url: URL(string: urlProtocol + urlToHost + urlUserLogIn)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("UTF-8", forHTTPHeaderField: "Charset")
        
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
        
        
        let sessionPost = URLSession.shared
        sessionPost.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                if let response = response {
                    print("\n\nResponse",response)
                }
                
                guard let data = data else { return }
                do {
                    let user = try JSONDecoder().decode(Entity.User.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(user, HTTPManager.cooikiesGetter(self.urlToHost))
                    }
                    
                } catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    func getFaculties(_ cookie: [HTTPCookie]) {
//        GET/ http://<host>/<entity>/getRecords
        let request = URLRequest(url: URL(string: urlProtocol + urlToHost + urlFaculties)!)
//        request.addValue("Set-Cookie", forHTTPHeaderField: cookie.value)
        //request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookie)
        print(cookie.first)
        //request.addValue("Set-Cookie", forHTTPHeaderField: (cookie.first?.value)!)
        
        let sessionGet = URLSession.shared
        sessionGet.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
            } else {
                if let response = response {
                    print("\n\nResponse",response)
                }
                
                guard let data = data else { return }
                do {
                    
                    //FIXME: fake decoding of json
                    let faculties = try JSONDecoder().decode(Entity.Faculty.self, from: data)
                    print(faculties)
                    print(String(data: data, encoding: .utf8))
                } catch {
                    print(error)
                }
            }
            
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
    
    
    func userLogout() {
        let sessionGet = URLSession.shared
        sessionGet.dataTask(with: URL(string: urlProtocol + urlToHost + urlUserLogOut)!) { (data, response, error) in
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
