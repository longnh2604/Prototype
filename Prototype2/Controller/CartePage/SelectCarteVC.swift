//
//  SelectCarteVC.swift
//  Prototype2
//
//  Created by Long on 2018/02/01.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "SelectedCarteCollectionCell"

class SelectCarteVC: UICollectionViewController {
    
    //Variable
    var customers: Results<CustomerData>!
    var cartes: Results<CarteData>!
    var receive_data : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = RealmServices.shared.realm
        customers = realm.objects(CustomerData.self)
        cartes = realm.objects(CarteData.self)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages.count)
        return cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelectedCarteCollectionCell
    
        // Configure the cell
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

    // MARK: UICollectionViewDelegate

    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
