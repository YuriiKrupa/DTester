//
//  DataManager.swift
//  DTester
//
//  Created by ITA student on 10/13/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import Foundation

class DataManager {
    
    var userName: String?
    var cookie: String?
    let defaults = UserDefaults.standard
    
    
    static let dataManager = DataManager()
    
    private init() {
        
        self.userName = defaults.string(forKey: "username")
        self.cookie = defaults.string(forKey: "cookie")
        /*} else {
            self.userName = nil
            self.cookie = nil
        }*/
        
    }
    
    func save(_ username: String, _ cookie: String) {
        defaults.set(username, forKey: "username")
        defaults.set(cookie, forKey: "cookie")
    }
    
}
