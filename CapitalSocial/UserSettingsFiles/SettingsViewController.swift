//
//  SettingsViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 14/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    //MARK: actions
    @IBAction func logOutButton(_ sender: Any) {
        DataPersistence.removeUserData()
        self.performSegue(withIdentifier: "segueLogOut", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = "Hola Usuario!"
        validateIfIsLogged()
        // Do any additional setup after loading the view.
    }

    func validateIfIsLogged() {
        let isLogged = DataPersistence.checkIfUserIsLogged()
        if isLogged.isLogged {
            if let userData = isLogged.userData {
                debugPrint(userData)
                labelName.text = "Hola " + userData.name
                if let photoURL = userData.photoURL {
                    if let photoPath = ServerManager.photoPath {
                        userImage.image = UIImage(named: photoPath)
                    }
                }
            }
        } else {
            debugPrint("THE USER IS NOT LOGGED DUDE! :´(")
        }
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
