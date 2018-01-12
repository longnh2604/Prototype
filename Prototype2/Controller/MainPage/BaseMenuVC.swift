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
        
        addMenuBarButton()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"sideMenuIcon"), style:.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        self.revealViewController().rearViewRevealWidth = 500
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
