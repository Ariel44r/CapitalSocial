//
//  DataBaseManager.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 06/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation
import SQLite3
import MapKit

class DataBaseManager {
    /*static func getPath() -> String {
        return "/Users/aramirez/Desktop/iOS/CapitalSocial/CapitalSocial/POI/quadrant_7167.db"
    }*/
    static func getPath() -> String {
        let dbURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dbPath = dbURL.appendingPathComponent("quadrant_7167.db")
        debugPrint("DATABASE PATH: \(dbPath.path)")
        return dbPath.path
    }
    
    static func connectToDB() -> OpaquePointer {
        let dbPath = getPath()
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("error opening database")
        } else {
            print("has successfully entered into POI database dude!")
        }
        return db!
    }
    
    static func getAnnotations() -> [Annotation] {
        var query: String
        query = "SELECT * FROM POI where id_category = 22"
        var annotations: [Annotation] = []
        let db = connectToDB()
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            var title: String = ""
            var latitude: Double = 0.0
            var longitude: Double = 0.0
            
            if let cString = sqlite3_column_text(statement, 2) {
                title = String(cString: cString)
            } else {
                print("name not found")
            }
            if let cString = sqlite3_column_text(statement, 3) {
                latitude = Double(String(cString: cString))!
                debugPrint(latitude)
            } else {
                print("name not found")
            }
            if let cString = sqlite3_column_text(statement, 4) {
                longitude = Double(String(cString: cString))!
                debugPrint(longitude)
            } else {
                print("name not found")
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let currentAnnotation = Annotation(title, title, coordinate)
            annotations.append(currentAnnotation)
        }
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        statement = nil
        return annotations
    }
}
