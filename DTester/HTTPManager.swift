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
//    GET/ http://<host>/<entity>/getRecords
    let urlFaculties = "/faculty/getRecords"
    
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
    
    func post(username: String, password:String, completionHandler: @escaping (_ responseUser: User, _ cookieVal: String) -> ()) {
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
                    let user = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(user, "response")
                    }
                    
                } catch {
                    print(error)
                }
                
                var cookies:[HTTPCookie] = HTTPCookieStorage.shared.cookies! as [HTTPCookie]
                print("Cookies Count = \(cookies.count)")
                for cookie:HTTPCookie in cookies as [HTTPCookie] {
                    print("\n\n",cookie.domain,"HOST",self.urlToHost)
                    if cookie.domain == self.urlToHost {
                        let cookieValue = cookie.value
                        //FIXME: !!!HERE RETURN COOKIE
                        print("\n")
                        print(cookie.value,"\n", cookieValue)
                        print("\n")
                    }
                }                
            }
            }.resume()
    }
    
    func getFaculties() {
//        GET/ http://<host>/<entity>/getRecords
        let sessionGet = URLSession.shared
        sessionGet.dataTask(with: URL(string: urlProtocol + urlToHost + urlFaculties)!) { (data, response, error) in
            
            if let error = error {
                print(error)
            } else {
                if let response = response {
                    print("\n\nResponse",response)
                }
                
                guard let data = data else { return }
                do {
                    let faculties = try JSONDecoder().decode(Entity.Faculty.self, from: data)
                    print(faculties)
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
