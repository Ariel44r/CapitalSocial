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
    }
    @IBAction func shareWhatsApp(_ sender: Any) {
        
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
