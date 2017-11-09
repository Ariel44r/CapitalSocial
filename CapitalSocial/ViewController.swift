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
    var nameUserFB: String?
    
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
        ServerManager.databaseDownload(databaseURL: Constants.dataBase.URLDB)
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
                self.getFBUserData() {
                    response, error in
                    if let response = response {
                        self.nameUserFB = response
                        if self.accessTokenValidation() {
                            self.performSegue(withIdentifier: "promosSegue", sender: nil)
                        }
                    }
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
    
    func getFBUserData(_ completion: @escaping(_ : String?, _ : Error?)->Void){
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (result != nil){
                    self.dict = result as! [String : AnyObject]
                    OperationQueue.main.addOperation({completion((self.dict["name"] as! String), nil)})
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



