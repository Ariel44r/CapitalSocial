//
//  FacebookData.swift
//
//
//  Created by Ariel Ramírez on 14/11/17.
//

import Foundation

class FaceBookData{
    var name: String
    var id: String
    var height: Int?
    var width: Int?
    var urlImage: String?
    init (_ data: [String : AnyObject]) {
        self.name = data["name"] as! String
        self.id = data["id"] as! String
    }
    init(_ name: String, _ id: String) {
        self.name = name
        self.id = id
    }
}

