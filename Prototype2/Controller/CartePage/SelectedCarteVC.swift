//
//  SelectedCarteVC.swift
//  Prototype2
//
//  Created by Long on 2018/02/01.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

class SelectedCarteVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var customers: Results<CustomerData>!
    var cartes: Results<CarteData>!
    var receive_data : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let realm = RealmServices.shared.realm
        customers = realm.objects(CustomerData.self)
        cartes = realm.objects(CarteData.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: CollectionView Delegate, Datasource
extension SelectedCarteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCarteCollectionCell", for: indexPath) as! SelectedCarteCollectionCell
        print(cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[indexPath.row])
        
        if let url = URL.init(string: cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[indexPath.row]) {
            let imageExtensions = ["png", "jpg", "gif"]
            let pathExtention = url.pathExtension
            
            if imageExtensions.contains(pathExtention)
            {
                //image
                cell.imvCarte.downloadedFrom(url: url)
            }else
            {
                
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages.count
    }
    
    func collectionView(_collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectedCarteCollectionCell
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
    }
    func collectionView(_collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectedCarteCollectionCell
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
    }
}
