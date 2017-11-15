//
//  MapKitViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 04/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {

    //MARK: Variables
    
    
    //Outlets
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapPlace()
        // Do any additional setup after loading the view.
    }
    
    func mapPlace() {
        let annotations = DataBaseManager.getAnnotations()
        MapView.addAnnotations(annotations)
        MapView.showAnnotations(MapView.annotations, animated: true)
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

