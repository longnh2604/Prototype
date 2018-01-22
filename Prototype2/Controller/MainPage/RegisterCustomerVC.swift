//
//  RegisterCustomerVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/18.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import Gallery

class RegisterCustomerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
}

extension RegisterCustomerVC: GalleryControllerDelegate {
    //Gallery Delegate
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]){
        
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video){
        
    }
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]){
        
    }
    func galleryControllerDidCancel(_ controller: GalleryController){
        dismiss(animated: true, completion: nil)
    }
}
