//
//  SettingVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/14.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class SettingVC: BaseMenuVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        slideMenuVC.dismiss(animated: true, completion: nil)
        RealmServices.shared.deleteAll()
    }
    
}
