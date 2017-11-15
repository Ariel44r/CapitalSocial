//
//  DataPersistence.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 14/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class DataPersistence {
    static func checkIfUserIsLogged() -> (isLogged: Bool, userData: FaceBookData?) {
        if UserDefaults.standard.object(forKey: "isLogged") != nil {
            let name = UserDefaults.standard.object(forKey: "name")
            let id = UserDefaults.standard.object(forKey: "id")
            let facebookData = FaceBookData(name as! String,id as! String)
            return (true, facebookData)
        }
        return (false,nil)
    }
    
    static func saveUserData(_ facebookData: FaceBookData) {
        UserDefaults.standard.set(1, forKey: "isLogged")
        UserDefaults.standard.set(facebookData.name, forKey: "name")
        UserDefaults.standard.set(facebookData.id, forKey: "id")
    }
    
    static func removeUserData() {
        UserDefaults.standard.removeObject(forKey: "isLogged")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "id")
    }
}
