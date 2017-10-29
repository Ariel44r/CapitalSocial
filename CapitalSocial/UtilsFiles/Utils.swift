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
        static func JSONObject() {
            
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
    }
}
