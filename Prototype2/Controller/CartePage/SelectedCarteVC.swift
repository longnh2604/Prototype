//
//  SelectedCarteVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class SelectedCarteVC: UIViewController {

    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var lblCusName: UILabel!
    @IBOutlet weak var lblLstCome: UILabel!
    @IBOutlet weak var lblMemo: UILabel!
    @IBOutlet weak var lblHobby: UILabel!
    @IBOutlet weak var lblBloodType: UILabel!
    @IBOutlet weak var lblCusBirth: UILabel!
    @IBOutlet weak var lblLstComeDay: UILabel!
    @IBOutlet weak var lblCusID: UILabel!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var tfMemo1: UITextView!
    @IBOutlet weak var tfMemo2: UITextView!
    @IBOutlet weak var tfMemo: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCameraPressed(_ sender: Any) {
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }

}
