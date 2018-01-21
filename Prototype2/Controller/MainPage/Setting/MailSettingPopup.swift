//
//  MailSettingPopup.swift
//  Prototype2
//
//  Created by Long on 2018/01/19.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class MailSettingPopup: UIViewController {

    @IBOutlet weak var tfWebmail: UITextField!
    @IBOutlet weak var tfSender: UITextField!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settingPressed(_ sender: Any) {
    
    }

}
