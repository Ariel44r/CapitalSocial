//
//  ResponseObj.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 29/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class Response {
    var CodigoRespuesta: String
    var Descripcion: String
    var ID_Usuario: String?
    var TokenSeguridad: String?
    
    init(_ CodigoRespuesta: String, _ Descripcion: String, _ ID_Usuario: String?, _ TokenSeguridad: String?) {
        self.CodigoRespuesta = CodigoRespuesta
        self.Descripcion = Descripcion
        self.ID_Usuario = ID_Usuario
        self.TokenSeguridad = TokenSeguridad
    }
}
