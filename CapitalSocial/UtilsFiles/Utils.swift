//
//  Utils.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 27/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import PKHUD

class StaticMethod {
    struct JSONManager {
        static func JSONData(_ JSONObject: Any) -> Data? {
            var data: Data?
            do {
                data = try JSONSerialization.data(withJSONObject: JSONObject, options: [])
                return data!
            } catch {
                debugPrint("Error while JSON Serialization: \(error)")
            }
            return nil
        }
        static func JSONToObject(_ JSON: NSDictionary) -> Response? {
            var response: Response?
            if let CodigoRespuesta = JSON["CodigoRespuesta"] as? String {
                if let Descripcion = JSON["Descripcion"] as? String {
                    response = Response(CodigoRespuesta,Descripcion,nil,nil)
                    return response
                }
            }
            return response
        }
    }
    struct PKHUD {
        static func viewProgressHUD() {
            HUD.show(.systemActivity)
        }
        static func viewProgressWithDelayHUD(_ delay: Double) {
            HUD.flash(.progress, delay: delay)
        }
        static func ViewProgressText(_ text: String) {
            HUD.show(.label(text))
        }
        static func dismissHUD() {
            HUD.hide()
        }
        static func imageHUD(_ image: UIImage, _ delay: Double) {
            HUD.flash(.image(image), delay: delay)
        }
        static func errorAndTextHUD(_ text: String) {
            HUD.show(.error)
            HUD.hide(afterDelay: 1.5, completion: {
                error in
                HUD.show(.label(text))
                HUD.hide(afterDelay: 4.0)
            })
        }
        static func successHUD() {
            HUD.flash(.success, delay: 1.5)
        }
    }
    struct StringProcess {
        static func replaceStringWithString(_ string: String, _ ocurrensOf: String, _ replaceWith: String) -> String {
            return (string.replacingOccurrences(of: ocurrensOf, with: replaceWith))
        }
        static func stringContainString(_ string: String, _ ocurrence: String) -> Bool {
            if string.range(of:ocurrence) != nil {
                return true
            }
            return false
        }
    }
}

class Constants {
    struct LogInConstants {
        static let URL = "http://209.222.19.75/wsAutorizador/api/autorizador/"
        static let endUrl = "AUTORIZADOR_ValidaUsuario"
    }
    struct messagesToUser {
        static let connectionFailed = "The Internet connection appears to be offline :'("
        static let validationFailed = "Validation failure, please try again later :'("
    }
}
