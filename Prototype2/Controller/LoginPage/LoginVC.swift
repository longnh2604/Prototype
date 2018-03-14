//
//  LoginVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/09.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import SVProgressHUD
import BarcodeScanner
import RealmSwift
import Firebase

class LoginVC: UIViewController {

    // Variable
    var customer: Results<CustomerData>!
    
    // IBOutlet
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
        
        let realm = RealmServices.shared.realm
        customer = realm.objects(CustomerData.self)
        
        RealmServices.shared.observerRealmErrors(in: self) { (error) in
            print(error ?? "No errors detected")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RealmServices.shared.stopObservingErrors(in: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBAction
    /***************************************************************/
    @IBAction func btnWebPressed(_ sender: Any) {
        UIApplication.tryURL(urls: ["https://abcarte.jp"])
    }
    
    @IBAction func btnFacebookPressed(_ sender: Any) {
        UIApplication.tryURL(urls: [
            "fb://profile/ipadabcarte", // App
            "http://www.facebook.com/ipadabcarte" // Website if app fails
            ])
    }
    
    @IBAction func btnCallPressed(_ sender: Any) {
        callNumber(phoneNumber: "0120357339")
    }
    
    func callNumber(phoneNumber:String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func btnLoginQRCodePressed(_ sender: Any) {
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        controller.errorDelegate = self
        controller.dismissalDelegate = self
        present(controller, animated: true, completion: nil)
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            userLogin()
            group.leave()
        }
        
        group.notify(queue: .main) {
            delay(5.00) {
                self.present(slideMenuVC, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - UIResponder Delegate
    /***************************************************************/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Barcode Scanner & Textfield
/***************************************************************/
extension LoginVC: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate, UITextFieldDelegate {
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        // Code processing
        controller.reset(animated: true)
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.openURL(URL(string: url)!)
                return
            }
        }
    }
}
