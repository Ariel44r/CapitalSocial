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
    var picture: [String: AnyObject]?
    var data: [String: AnyObject]?
    var photoURL: String?
    init (_ data: [String : AnyObject]) {
        self.name = data["name"] as! String
        self.id = data["id"] as! String
        self.picture = data["picture"] as? [String : AnyObject]
        self.data = picture!["data"] as? [String: AnyObject]
        self.photoURL = self.data!["url"] as? String
    }
    init(_ name: String, _ id: String, _ photoURL: String) {
        self.name = name
        self.id = id
        self.photoURL = photoURL
    }
}

