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
    
    //IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variable
    var customers: Results<CustomerData>!
    var cartes: Results<CarteData>!
    var receive_data : [String:Any]?
    var OrderNo: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        let realm = RealmServices.shared.realm
        customers = realm.objects(CustomerData.self)
        cartes = realm.objects(CarteData.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - CollectionView Delegate, Datasource
/***************************************************************/
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
        let cell = collectionView.cellForItem(at: indexPath) as! SelectedCarteCollectionCell
        OrderNo += 1
        cell.lblCellNo.text = String(OrderNo)
        cell.lblCellNo.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("did deselect")
        let cell = collectionView.cellForItem(at: indexPath) as! SelectedCarteCollectionCell
        OrderNo -= 1
        cell.lblCellNo.isHidden = true
        let cellNo = Int(cell.lblCellNo.text!)
        //reload cell number in order
        compareNumber(cellNumber: cellNo!)
    }
    
    func compareNumber(cellNumber:Int) {
        for cell in self.collectionView.visibleCells as! [SelectedCarteCollectionCell] {
            if cell.lblCellNo.isHidden {
                //dag hidden
            } else {
                var noOrder = Int(cell.lblCellNo.text!)
                print(noOrder ?? 0)
                print(OrderNo)
                print(cellNumber)
                if noOrder! > cellNumber {
                    noOrder = noOrder! - 1
                    cell.lblCellNo.text = String(noOrder!)
                } else {
                    
                }
            }
        }
    }
}
