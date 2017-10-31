//
//  ViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 26/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: actionButtons
    @IBAction func buttonLogInFacebook(_ sender: Any) {
    }
    @IBAction func buttonLogInPhone(_ sender: Any) {
        logInPhoneRequest()
    }
    
    //MARK: outlets
    @IBOutlet weak var textFieldPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Methods
    func logInPhoneRequest() {
        ServerManager.postRequest(textFieldPhone.text!) {
            response, error in
            if let response = response {
                StaticMethod.PKHUD.successHUD()
                self.performSegue(withIdentifier: "promosSegue", sender: nil)
                debugPrint(response.Descripcion)
            }
            if let error = error {
                StaticMethod.PKHUD.errorAndTextHUD(Constants.messagesToUser.validationFailed)
                debugPrint(error)
            }
        }
    }
    
}

