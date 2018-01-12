//
//  BaseMenuVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/12.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class BaseMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"sideMenuIcon"), style:.plain, target: self, action: #selector(barButtonSelected))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func barButtonSelected() {
        print("Bar button selected")
    }

}
