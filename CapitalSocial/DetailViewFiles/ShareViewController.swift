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
    var documentInteractionController: UIDocumentInteractionController = UIDocumentInteractionController()
    
    //MARK: outlets
    
    
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
        debugPrint("WhatsApp SHARE!")
        let urlWhats = "whatsapp://app"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    
                    if let image = UIImage(named: namePhoto!) {
                        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                            let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
                            do {
                                try imageData.write(to: tempFile, options: .atomic)
                                self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                                self.documentInteractionController.uti = "net.whatsapp.image"
                                self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
                                
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                } else {
                    // Cannot open whatsapp
                }
            }
        }
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
