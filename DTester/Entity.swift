//
//  Entity.swift
//  DTester
//
//  Created by ITA student on 10/12/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import Foundation

class Entity {
//Faculty: {faculty_id, faculty_name, faculty_description}
    struct Faculty: Decodable {
        let faculty_id: String
        let faculty_name: String
        let faculty_description: String
        
        init(json: [String: Any]) {
            faculty_id = json["faculty_id"] as? String ?? "-1"
            faculty_name = json["faculty_name"] as? String ?? ""
            faculty_description = json["faculty_description"] as? String ?? ""
        }
    }
}
