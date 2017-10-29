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
        StaticMethod.PKHUD.viewProgressHUD()
        let url = URL(string: "http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_ValidaUsuario")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let parameters: Any = [
            "Telefono":phone
        ]
        if let parametersData = StaticMethod.JSONManager.JSONData(parameters) {
            urlRequest.httpBody = parametersData
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(urlRequest).validate().responseJSON{
            response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    debugPrint("Validation Successful")
                    debugPrint("JSON: \(json)")
                    StaticMethod.PKHUD.dismissHUD()
                }
            case .failure(let error):
                debugPrint("Error at receive response: \(error)")
                StaticMethod.PKHUD.errorAndTextHUD("Error: Validation failure, please try again later :'(")
            }
        }
    }
}
