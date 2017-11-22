//
//  AnnotationsTableView.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 21/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit
import RealmSwift

class AnnotationCell: UITableViewCell {
    
    //MARK:  outletsAndActions
    @IBOutlet weak var annotationName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class AnnotationsTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: variablesAndInstances
    let realm = try! Realm()
    var results: Results<AnnotationObj>?
    let reuseIdentifier: String = "Cell"
    
    //MARK: outletsAndActions
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var annotationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let query = RealmManager.realmQuery("latitude > 19") {
            self.results = query
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = self.results {
            return results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AnnotationCell
        cell.annotationName.text = results![indexPath.row].locationName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionSheetFuncImage(indexPath.row)
    }
    
    func actionSheetFuncImage(_ index: Int) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Annotation", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("delete Annotation")
            let object: Object = self.results![index] as Object
            RealmManager.deleteFromRealm(object)
            self.annotationTableView.reloadData()
        })
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}


