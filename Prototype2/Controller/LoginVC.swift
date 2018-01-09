//
//  LoginVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/09.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfShopPassword: UITextField!
    @IBOutlet weak var tfShopId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        tfShopPassword.delegate = self
        tfShopId.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginQRCodePressed(_ sender: Any) {
        
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
        if tfUsername.text != nil && tfPassword.text != nil {
            AuthServices.instance.loginUser(withEmail: tfUsername.text!, andPassword: tfPassword.text!, loginComplete: { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: error??.localizedDescription))
                }
            })
        }
    }
    
    //get the cloud database
    func loadCloudDatabase(){
//        let container = CKContainer.default()
//        let privateDatabase = container.publicCloudDatabase
//        let predicate = NSPredicate(value: true)
//
//        let query = CKQuery(recordType: "CustomerData", predicate: predicate)
//
//        privateDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
//            if error != nil {
//                print(error!)
//                SVProgressHUD.showError(withStatus: error?.localizedDescription)
//            }
//            else {
//                print(results!)
//
//                for result in results! {
//                    GlobalVariables.sharedManager.cusRecord.append(result)
//                }
//
//                OperationQueue.main.addOperation({ () -> Void in
//                    SVProgressHUD.dismiss()
//                    self.goToMainPage()
//                })
//            }
//        }
    }
    
    func goToMainPage(){
//        let storyboard = UIStoryboard(name: "MainScene", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "MainPageViewController") as! MainPageVC
//
//        self.present(controller, animated: true, completion: nil)
    }
    
    //MARK: - Textfield Delegate
    /***************************************************************/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - UIResponder Delegate
    /***************************************************************/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
