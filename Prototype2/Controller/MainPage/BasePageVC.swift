//
//  BasePageVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/16.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class BasePageVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        naviMain.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
