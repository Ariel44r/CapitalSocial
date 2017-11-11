//
//  ShareViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 07/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit
import Social
import FacebookShare
import FacebookCore

class ShareViewController: UIViewController {

    //MARK: variablesAndInstances
    var namePhoto: String? = nil
    
    //MARK: actions
    @IBAction func shareFacebook(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            debugPrint("Facebook is Available")
            let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            post?.setInitialText("Post of the day")
            if let namePhoto = self.namePhoto {
                post?.add(UIImage(named: namePhoto))
            }
            self.present(post!, animated: true, completion: nil)
        }
        else {
            StaticMethod.PKHUD.errorAndTextHUD("You are not logged in to your Facebook account.")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func shareTwitter(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            debugPrint("Twitter is Available")
            let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            post?.setInitialText("Post of the day")
            if let namePhoto = self.namePhoto {
                post?.add(UIImage(named: namePhoto))
            }
            self.present(post!, animated: true, completion: nil)
        }
        else {
            StaticMethod.PKHUD.errorAndTextHUD("You are not logged in to your Twitter account.")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func shareWhatsApp(_ sender: Any) {
        let date = Date()
        let msg = "Hi my dear friends\(date)"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    StaticMethod.PKHUD.errorAndTextHUD("Please install watsapp")
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
