//
//  CollectionViewController.swift
//  CapitalSocial
//
//  Created by Ariel Ramírez on 30/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DetailViewControllerDelegate {

    var promos = [String]()
    let reusableIdentifier = "Cell"
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 50.0, right: 20.0)
    var tapGesture: UITapGestureRecognizer? // = UITapGestureRecognizer(target: self, action: #selector (didTapView(gesture:)))
    var promoName: String?
    var cordinate: CGPoint?
    let transition = TransitionShare()
    var searchActive: Bool = false
    
    //MARK: outlets
    @IBOutlet weak var promoCollection: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            StaticMethod.PKHUD.successHUD()
        // Do any additional setup after loading the view.
        refreshPromos("")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeObservers()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func refreshPromos(_ searchTerm: String) {
        PromosProcess.searchFilter(searchTerm) {
            results in
            if let results = results {
                self.promos = results
            }
            self.promoCollection.reloadData()
        }
    }
    
    func setScroll() {
        let cgPoint = CGPoint(x: 0,y: 80)
       scrollView.setContentOffset(cgPoint, animated: true)
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
        cell.promoImage.image = UIImage(named: promos[indexPath.item] + "@1.5x" + ".png")
        cell.promoLabel.text = StaticMethod.StringProcess.replaceStringWithString(promos[indexPath.item], "Promo", "")
        cell.promoLabel.textColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("SELECT ITEM: \(indexPath.item)")
        let cellContentView = collectionView.cellForItem(at: indexPath)?.contentView
        let rect = cellContentView!.convert(cellContentView!.frame, to: self.view) // pass toView nil if you want to convert rect relative to window
        cordinate = CGPoint(x: rect.origin.x + rect.size.width / 2, y: rect.origin.y + rect.size.height / 2)
        promoName = promos[indexPath.item]
        self.performSegue(withIdentifier: "segueDetail", sender: nil)
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

//MARK: UISearchBarDelegate
extension CollectionViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        refreshPromos(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector (didTapView(gesture:)))
        view.addGestureRecognizer(self.tapGesture!)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        view.removeGestureRecognizer(self.tapGesture!)
        setScroll()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
}

//MARK: UITextFieldDelegate
extension CollectionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText:String
        if(string != ""){
            newText = textField.text! + string
        }else{
            newText = textField.text!.substring(to: textField.text!.index(before: textField.text!.endIndex))
        }
        refreshPromos(newText)
        return true
    }
    
    //MARK: manageKeyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return true
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
        let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height,right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
}

//MARK: Segue
extension CollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.delegate = self
        detailVC.promoName = self.promoName!
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .custom
    }
}

//MARK: delegateFunctions
extension CollectionViewController {
    func returnToCollection() {
    }
}

extension CollectionViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.cordinate!
        transition.bubbleColor = UIColor.clear
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.cordinate!
        transition.bubbleColor = UIColor.clear
        return transition
    }
}

