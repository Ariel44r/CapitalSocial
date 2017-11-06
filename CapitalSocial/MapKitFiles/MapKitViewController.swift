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
        var annotations: [Annotation] = []
        let coordinate1 = CLLocationCoordinate2D(latitude: 19.29888, longitude: -99.36861)
        let annotation1 = Annotation("title1","location1", coordinate1)
        let coordinate2 = CLLocationCoordinate2D(latitude: 19.0, longitude: -99.39)
        let annotation2 = Annotation("title1","location1", coordinate2)
        annotations.append(annotation1)
        annotations.append(annotation2)
        MapView.addAnnotations(annotations)
    }
    
    func mapPlace1() {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(19.29888, -99.36861)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        MapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "visit me!"
        annotation.subtitle = "hey!"
        MapView.addAnnotation(annotation)
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

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    //let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(_ title: String, _ locationName: String, _ coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        //self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
}
