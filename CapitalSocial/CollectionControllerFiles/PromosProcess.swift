//
//  PromosProcess.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 30/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class PromosProcess {
    
    static var promos = ["PromoBenavides", "PromoBurguerKing", "PromoChilis", "PromoCinepolis", "PromoIdea", "PromoItaliannis", "PromoPapaJohns", "PromoTizoncito", "PromoWingstop", "PromoZonaFitness"]
    
    static func searchFilter(_ searchTerm: String, completion : @escaping (_ results: [String]?) -> Void) {
        var searchPromoForName = [String]()
        if searchTerm == "" || searchTerm == "\n" {
            searchPromoForName = promos
        } else {
            for promo in promos {
                if (promo.lowercased().range(of: searchTerm.lowercased()) != nil) {
                    searchPromoForName.append(promo)
                }
            }
        }
        OperationQueue.main.addOperation ({
            completion(searchPromoForName)
        })
    }
}
