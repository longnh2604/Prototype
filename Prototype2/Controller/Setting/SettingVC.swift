//
//  SettingVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/14.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import PopupDialog
import SVProgressHUD

class SettingVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBAction
    /***************************************************************/
    @IBAction func logoutPressed(_ sender: Any) {
        SVProgressHUD.show()
        RealmServices.shared.deleteAll()
        slideMenuVC.dismiss(animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    
    @IBAction func mailPressed(_ sender: Any) {
        
    }
    
    @IBAction func cloudPressed(_ sender: Any) {
        openPoup(message: "Your ABCarte is up to date. Currently, ABCarte don't have any news data to Sync")
    }
    
    @IBAction func accountPressed(_ sender: Any) {
        
    }
    
    //MARK: - Popup
    /***************************************************************/
    func openPoup(message: String) {
        let title = "ALERT"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message)
        
        // Create buttons
        let buttonOne = CancelButton(title: "CANCEL") {
            
        }
        
        let buttonTwo = DefaultButton(title: "CONFIRM", height: 60) {
            
        }

        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
}
