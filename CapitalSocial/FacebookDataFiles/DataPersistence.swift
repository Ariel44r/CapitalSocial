//
//  DataPersistence.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 14/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class DataPersistence {
    static func checkIfUserIsLogged() -> (isLogged: Bool, userData: FaceBookData?, phone: String?) {
        if UserDefaults.standard.object(forKey: "isLoggedFacebook") != nil {
            let name = UserDefaults.standard.object(forKey: "name")
            let id = UserDefaults.standard.object(forKey: "id")
            let photoURL = UserDefaults.standard.object(forKey: "photoURL")
            let facebookData = FaceBookData(name as! String,id as! String, photoURL as! String)
            return (true, facebookData,nil)
        }
        if UserDefaults.standard.object(forKey: "isLoggedPhone") != nil {
            let phone = UserDefaults.standard.object(forKey: "phone") as! String
            return (true,nil,phone)
        }
        return (false,nil,nil)
    }
    
    static func saveUserData(_ facebookData: FaceBookData) {
        UserDefaults.standard.set(1, forKey: "isLoggedFacebook")
        UserDefaults.standard.set(facebookData.name, forKey: "name")
        UserDefaults.standard.set(facebookData.id, forKey: "id")
        UserDefaults.standard.set(facebookData.photoURL, forKey: "photoURL")
    }
    
    static func saveUserDataPhone(_ phone: String) {
        UserDefaults.standard.set(1, forKey: "isLoggedPhone")
        UserDefaults.standard.set(phone, forKey: "phone")
    }
    
    static func removeUserData() {
        UserDefaults.standard.removeObject(forKey: "isLoggedFacebook")
        UserDefaults.standard.removeObject(forKey: "isLoggedPhone")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "photoURL")
        UserDefaults.standard.removeObject(forKey: "phone")
    }
}
