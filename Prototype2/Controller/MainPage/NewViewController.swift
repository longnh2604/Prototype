//
//  NewViewController.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/12.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sideMenu() {
        
        if revealViewController() != nil {
            
            sideMenuBtn.target = revealViewController()
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 500
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
