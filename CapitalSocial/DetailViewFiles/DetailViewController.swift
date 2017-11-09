//
//  DetailViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 03/11/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func returnToCollection()
}

class DetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: Instances
    weak var delegate: DetailViewControllerDelegate?
    var promoName: String?
    let transition = TransitionShare()

    //MARK: Outlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tumbnailImage: UIImageView!
    @IBOutlet weak var payOffLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    
    //MARK: Actions
    @IBAction func backButton(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
        delegate?.returnToCollection()
    }
    @IBAction func shareButton(_ sender: Any) {
        self.performSegue(withIdentifier: "segueShare", sender: nil)
        //nativeShare()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as! ShareViewController
        shareVC.transitioningDelegate = self
        shareVC.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startinngPoint = shareButton.center
        transition.circleColor = shareButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startinngPoint = shareButton.center
        transition.circleColor = shareButton.backgroundColor!
        return transition
    }
    
    func nativeShare() {
        let activityVC = UIActivityViewController(activityItems: [mainImage.image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.backgroundColor = UIColor.black
        if let promoName = promoName {
            fillInFields(promoName)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillInFields(_ promoName: String) {
        mainImage.image = UIImage(named: promoName + ".png")
        tumbnailImage.image = UIImage(named: promoName + "@1.5x" + ".png")
        payOffLabel.text = StaticMethod.StringProcess.replaceStringWithString(promoName, "Promo", "")
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
