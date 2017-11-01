//
//  ViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 26/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController {

    //MARK: variablesAndInstances
    var dict : [String : AnyObject]!
    
    //MARK: outlets
    @IBOutlet weak var textFieldPhone: UITextField!
    
    //MARK: actionButtons
    @IBAction func buttonLogInPhone(_ sender: Any) {
        logInPhoneRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        faceBookLogInButton()
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

extension ViewController {
    func faceBookLogInButton() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        //adding it to view
        view.addSubview(loginButton)
    }
    
    func customLogInButton() {
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center
        myLoginButton.setTitle("LoginButton", for: .normal)
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        // Add the button to the view
        view.addSubview(myLoginButton)
    }
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
                debugPrint("LOGIN SUCCESS")
            }
        }
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    debugPrint("DICTIONARY: \(self.dict!)")
                }
            })
        }
    }
    func accessToken() {
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
            debugPrint(accessToken.appID)
            self.performSegue(withIdentifier: "promosSegue", sender: nil)
        }
    }
}



