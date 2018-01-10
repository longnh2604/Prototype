//
//  SecretVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class SecretVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add gesture swipe left to dismiss
        let slideRight = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideRight.direction = .right
        view.addGestureRecognizer(slideRight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
