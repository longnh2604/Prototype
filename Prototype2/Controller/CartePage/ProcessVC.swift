//
//  ProcessVC.swift
//  Prototype2
//
//  Created by Long on 2018/02/02.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

class ProcessVC: UIViewController {

    // IBOutlet
    @IBOutlet weak var viewPic1: UIView!
    @IBOutlet weak var viewPic2: UIView!
    @IBOutlet weak var imvPicture: UIImageView!
    @IBOutlet weak var imvPicture1: UIImageView!
    @IBOutlet weak var imvPicture2: UIImageView!
    @IBOutlet weak var viewPic: UIView!
    
    // Variable
    var receive_data : [String:Any]?
    var cartes: Results<CarteData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmServices.shared.realm
        cartes = realm.objects(CarteData.self)
    }
    
    func loadImage() {
        if receive_data != nil {
            for (key, value) in receive_data! {
                if let array = value as? [Int]{
                    if array.count == 1 {
                        viewPic1.isHidden = true
                        viewPic2.isHidden = true
                        imvPicture.downloadedFrom(link: cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[array[0]])
                    }
                    if array.count == 2 {
                        viewPic1.isHidden = false
                        viewPic2.isHidden = false
                        imvPicture1.downloadedFrom(link: cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[array[0]])
                        imvPicture2.downloadedFrom(link: cartes[GlobalVariables.sharedManager.cellCarteIndex].carteImages[array[1]])
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("in gia tri process \(GlobalVariables.sharedManager.typeProcess)")
        print("Receive data \(String(describing: receive_data ))")
        loadImage()
    }
}
