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
    let transition = TransitionShare()
    var startAnimationPoint = CGPoint(x: 0.0, y: 0.0)
    
    //MARK: outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginFacebookButton: UIButton!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: actionButtons
    @IBAction func buttonLogInPhone(_ sender: Any) {
        startAnimationPoint = loginButton.center
        logInPhoneRequest()
        DataPersistence.saveUserDataPhone(textFieldPhone.text!)
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
        startAnimationPoint = loginFacebookButton.center
        loginFacebookInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerManager.databaseDownload(databaseURL: Constants.dataBase.URLDB)
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        if DataPersistence.checkIfUserIsLogged().isLogged {
            self.performSegue(withIdentifier: "promosSegue", sender: nil)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let collectionVC = segue.destination as! UITabBarController
        collectionVC.transitioningDelegate = self
        collectionVC.modalPresentationStyle = .custom
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
            case .success( _, _, _):
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
                    debugPrint(self.dict)
                    let facebookData = FaceBookData(self.dict)
                    DataPersistence.saveUserData(facebookData)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startAnimationPoint
        transition.bubbleColor = loginButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = startAnimationPoint
        transition.bubbleColor = loginButton.backgroundColor!
        return transition
    }
}



