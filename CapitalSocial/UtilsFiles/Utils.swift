//
//  Utils.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 27/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import PKHUD

class Constants {
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
    }
}
