//
//  MapKitViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 04/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate {

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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let selectedAnnotation = view.annotation as? Annotation {
            displayalert("Obtener Dirección de \(selectedAnnotation.title!)?", selectedAnnotation)
        }
    }
    
    func displayalert(_ userMessage:String, _ annotation: Annotation) {
        
        let myalert = UIAlertController(title:"Aviso", message:userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"ok", style: UIAlertActionStyle.default, handler:{ (action: UIAlertAction!) in
            //callMaps
            self.goToMaps(annotation)
        })
        myalert.addAction(okAction)
        
        let cancelaction = UIAlertAction(title:"cancel", style: UIAlertActionStyle.default, handler:nil)
        myalert.addAction(cancelaction)
        
        self.present(myalert, animated:true, completion:nil)
    }
    
    func goToMaps(_ annotation: Annotation) {
        let currentLocMapItem = MKMapItem.forCurrentLocation()
        let selectedPlacemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        
        let mapItems = [selectedMapItem, currentLocMapItem]
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
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

