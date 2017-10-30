//
//  CollectionViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 30/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var promos = ["PromoBenavides", "PromoBurguerKing", "PromoChilis", "PromoCinepolis", "PromoIdea", "PromoItaliannis", "PromoPapaJohns", "PromoTizoncito", "PromoWingstop", "PromoZonaFitness"]
    let reusableIdentifier = "Cell"
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: DataSource
extension CollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! PromosCell
        //cell.backgroundColor = UIColor.cyan
        cell.promoImage.image = UIImage(named: promos[indexPath.item] + ".png")
        cell.promoLabel.text = StaticMethod.StringProcess.replaceStringWithString(promos[indexPath.item], "Promo", "")
        return cell
    }
    
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}



