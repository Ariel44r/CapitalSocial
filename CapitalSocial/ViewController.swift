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
        ServerManager.postRequest(textFieldPhone.text!)
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


}

