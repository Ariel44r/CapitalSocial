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
        let url = URL(string: "http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_ValidaUsuario")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let parameters = [
            "Telefono":phone
        ]
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            debugPrint(error)
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(urlRequest).responseJSON{
            response in
            //debugPrint(response.result)
            if let json = response.result.value {
                debugPrint("JSON: \(json)")
                Constants.PKHUD.dismissHUD()
            }
        }
    }
}
