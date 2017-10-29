//
//  AlamoFire.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 27/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {
    static func postRequest(_ phone: String) {
        Constants.PKHUD.ViewProgressText("Sending request")
        let parameters = [
            "Telefono":phone
        ]
        
        Alamofire.request("http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_ValidaUsuario", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            debugPrint(response)
            Constants.PKHUD.dismissHUD()
        })
    }
}
