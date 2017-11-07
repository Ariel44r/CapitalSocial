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
    static func postRequest(_ phone: String,_ completion: @escaping (_ : Response?, _ : Error?) -> Void) {
        StaticMethod.PKHUD.viewProgressHUD()
        let url = URL(string: (Constants.LogInConstants.URL + Constants.LogInConstants.endUrl))!
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
                        debugPrint("JSON: \(json)")
                        //callJSONToObject
                        let response = StaticMethod.JSONManager.JSONToObject(json as! NSDictionary)
                        OperationQueue.main.addOperation({
                            completion(response, nil)
                        })
                }
                case .failure(let error):
                    if availableConnection(error.localizedDescription) {
                        StaticMethod.PKHUD.errorAndTextHUD(Constants.messagesToUser.connectionFailed)
                    } else {
                        OperationQueue.main.addOperation({completion(nil, error)})
                    }
            }
        }
    }
    
    static func getDataBase() -> Data? {
        var data: Data?
        do {
            data = try Data(contentsOf: URL(string: Constants.dataBase.URLDB)!)
            if let data = data {
                debugPrint(data)
                return data
            }
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
    static func availableConnection(_ str: String) -> Bool {
        return (StaticMethod.StringProcess.stringContainString(str, Constants.messagesToUser.connectionFailed))
    }
}
