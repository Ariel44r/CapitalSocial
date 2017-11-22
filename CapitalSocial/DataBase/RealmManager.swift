//
//  RealmManager.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 21/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    static let realm = try! Realm()
    
    static func addToRealm(_ annotattion: Annotation) {
        let annotationObjc = AnnotationObj()
        annotationObjc.title = annotattion.title!
        annotationObjc.locationName = annotattion.locationName
        annotationObjc.latitude = annotattion.coordinate.latitude
        annotationObjc.longitude = annotattion.coordinate.longitude
        realm.beginWrite()
        realm.add(annotationObjc)
        try! realm.commitWrite()
        StaticMethod.PKHUD.annotationSaved()
    }
    
    static func deleteFromRealm(_ annotation: Object) {
        realm.beginWrite()
        realm.delete(annotation)
        //let objectToDelete = realm.objects(AnnotationObj.self).filter(NSPredicate(format: string))
        //realm.delete(objectToDelete)
        try! realm.commitWrite()
    }
    
    static func realmQuery(_ string: String) -> Results<AnnotationObj>? {
        return (realm.objects(AnnotationObj.self).filter(NSPredicate(format: string)))
    }
}
