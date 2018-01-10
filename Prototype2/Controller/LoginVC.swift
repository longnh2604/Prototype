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

class LoginVC: UIViewController,UITextFieldDelegate,BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate {

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
        let controller = BarcodeScannerController()
        controller.codeDelegate = self
        controller.errorDelegate = self
        controller.dismissalDelegate = self
        present(controller, animated: true, completion: nil)
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
       SVProgressHUD.show()

    }
    
    //Load the cloud database
    func loadCloudDatabase(){
//        let db = Firestore.firestore()
//        db.collection("customerData").getDocuments { (querySnapshot, error) in
//            if let error = error {
//                SVProgressHUD.showError(withStatus: error.localizedDescription)
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
        
//        performSegue(withIdentifier: "goToMainPage", sender: nil)
//        SVProgressHUD.dismiss()
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
    
    //MARK: - Barcode Scanner Delegate
    /***************************************************************/
    
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
