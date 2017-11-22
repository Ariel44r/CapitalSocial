//
//  MapKitViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 04/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapKitViewController: UIViewController, MKMapViewDelegate {

    //MARK: Variables
    let rightButton = UIButton(type: .contactAdd)
    var selectedAnnotation: Annotation?
    let realm = try! Realm()
    
    //Outlets
    @IBOutlet weak var MapView: MKMapView!
    @IBAction func myAnnotationsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "AnnotationsSegue", sender: nil)
    }
    
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
        selectedAnnotation = view.annotation as? Annotation
        rightButton.addTarget(self, action:#selector(annotationButton), for: .touchUpInside)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
            rightButton.tag = annotation.hash
            pinView.animatesDrop = false
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton
            return pinView
        }
        else {
            return nil
        }
    }
    
    @objc func annotationButton() {
        actionSheetFuncImage()
    }
    
    func goToMaps(_ annotation: Annotation) {
        let currentLocMapItem = MKMapItem.forCurrentLocation()
        let selectedPlacemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        
        let mapItems = [selectedMapItem, currentLocMapItem]
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
    }
    
    func actionSheetFuncImage() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let openInMaps = UIAlertAction(title: "Open in Maps", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("open in maps")
            if let selectedAnnotation = self.selectedAnnotation{
                self.goToMaps(selectedAnnotation)
            }
        })
        
        let saveAnnotation = UIAlertAction(title: "Save Annotation", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("save annotation")
            if let selectedAnnotation = self.selectedAnnotation{
                RealmManager.addToRealm(selectedAnnotation)
            }
        })
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        optionMenu.addAction(openInMaps)
        optionMenu.addAction(saveAnnotation)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
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

