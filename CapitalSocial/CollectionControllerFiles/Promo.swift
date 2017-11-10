//
//  Promo.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 01/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class Promo {
    var name: String
    var nameTumbnail: String
    var imagePath: String
    
    init (_ name: String, _ nameTumbnail: String, _ imagePath: String) {
        self.name = name
        self.nameTumbnail = nameTumbnail
        self.imagePath = imagePath
    }
}
