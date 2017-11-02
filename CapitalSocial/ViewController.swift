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
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: actionButtons
    @IBAction func buttonLogInPhone(_ sender: Any) {
        logInPhoneRequest()
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
        loginFacebookInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        faceBookLogInButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeObservers()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Methods
    func loginFacebookInit() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self, completion: {
            loginResult in
            switch loginResult {
            case .failed(let error):
                debugPrint(error)
                break
            case .cancelled:
                StaticMethod.PKHUD.errorAndTextHUD(Constants.messagesToUser.cancelledLogin)
                break
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                StaticMethod.PKHUD.viewProgressHUD()
                self.getFBUserData()
                if self.accessTokenValidation() {
                    self.performSegue(withIdentifier: "promosSegue", sender: nil)
                }
                break
            }
        })
    }
    
    func logInPhoneRequest() {
        ServerManager.postRequest(textFieldPhone.text!) {
            response, error in
            if let response = response {
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
        let loginButton = UIButton(frame: CGRect(x: 40, y: 200, width: 100, height: 40))
        //let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        //adding it to view
        //view.addSubview(loginButton)
    }
    
    /*func customLogInButton() {
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.blue
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center
        myLoginButton.setTitle("LoginButton", for: .normal)
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        // Add the button to the view
        getFBUserData()
        view.addSubview(myLoginButton)
    }*/
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (result != nil){
                    self.dict = result as! [String : AnyObject]
                    debugPrint("DICTIONARY: \(self.dict!)")
                }
            })
        }
    }
    func accessTokenValidation() -> Bool {
        if let accessToken = FBSDKAccessToken.current(){
            debugPrint(accessToken.appID)
            return true
        }
        return false
    }
}

//MARK: manageKeyboard
extension ViewController: UITextFieldDelegate {
    //MARK: manageKeyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            self.logInPhoneRequest()
        }
        return true
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (frame.height + 50),right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(_ notification: Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
}



