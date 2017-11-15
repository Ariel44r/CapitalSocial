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
    
    //MARK: actions
    @IBAction func logOutButton(_ sender: Any) {
        self.performSegue(withIdentifier: "segueLogOut", sender: nil)
        DataPersistence.removeUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isLogged = DataPersistence.checkIfUserIsLogged()
        if isLogged.isLogged {
            if let userData = isLogged.userData {
                debugPrint(userData)
                labelName.text = "Hola " + userData.name
            }
        } else {
            debugPrint("THE USER IS NOT LOGGED DUDE! :´(")
        }
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
