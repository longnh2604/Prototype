//
//  AccountInfoPopup.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/20.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class AccountInfoPopup: UIViewController {

    @IBOutlet weak var imvAccount: UIImageView!
    @IBOutlet weak var tfAccName: UITextField!
    @IBOutlet weak var tfAccPassword: UITextField!
    @IBOutlet weak var tfAccType: UITextField!
    @IBOutlet weak var tfCusTotal: UITextField!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        tfAccName.text = "\(UserDefaults.standard.string(forKey: "username")!) 様"
        tfAccType.text = UserDefaults.standard.string(forKey: "rules")!
        tfCusTotal.text = UserDefaults.standard.string(forKey: "cusTotal")
        tfAccPassword.text = UserDefaults.standard.string(forKey: "userPassword")
        
        if let url = URL.init(string: UserDefaults.standard.string(forKey: "imageURL")!) {
            imvAccount.downloadedFrom(url: url)
            imvAccount.roundImage(with: imvAccount)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func settingPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}