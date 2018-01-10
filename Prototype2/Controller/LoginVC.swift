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
import CloudKit
import RealmSwift

class LoginVC: UIViewController,UITextFieldDelegate,BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate {

    let realm = try! Realm()
    var customer: Results<CustomerData>?
    
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
        loadCloudDatabase()
    }
    
    //Get the CloudKit Database
    func loadCloudDatabase(){
        
        let container = CKContainer.default()
        let privateDB = container.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        let zone = CKRecordZone(zoneName: "PrototypeZone")

        let query = CKQuery(recordType: "customerData", predicate: predicate)
        
        privateDB.perform(query, inZoneWith: zone.zoneID) { (results, error) -> Void in
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                return
            }

            OperationQueue.main.addOperation({ () -> Void in
                if self.realm.isEmpty {
                    for result in results! {
                        let newCustomer = CustomerData()
                        newCustomer.cusName = result.value(forKey: "cusName") as! String
                        newCustomer.cusID = result.value(forKey: "cusID") as! String
                        newCustomer.cusSex = result.value(forKey: "cusSex") as! String
                        newCustomer.cusLstCome = result.value(forKey: "cusLstCome") as? Date
                        newCustomer.cusBirth = result.value(forKey: "cusBirth") as? Date
                        newCustomer.cusMailInbox = result.value(forKey: "cusMailInbox") as! Int
                        newCustomer.cusMailOpen = result.value(forKey: "cusMailOpen") as! Int
                        newCustomer.cusMailError = result.value(forKey: "cusMailError") as! Int
                        newCustomer.cusMailUnopen = result.value(forKey: "cusMailUnopen") as! Int
                        newCustomer.cusCarte.append(String(describing: result["carte"]))
//                        if let cartes = result.value(forKey: "carte") {
//                            var carteIds = [CKRecordID]()
//                            for carteRef in result["carte"] as! [CKReference] {
//                                carteIds.append(carteRef.recordID)
//                                newCustomer.cusCarte.append(String(describing: carteIds))
//                            }
//                        }
                        
                        self.save(customer: newCustomer)
                    }
                }
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToMainPage", sender: nil)
            })
        }
    }
    
    // MARK: Realm
    func save(customer: CustomerData) {
        do {
            try realm.write {
                realm.add(customer)
            }
        } catch {
            print("Error Saving Customer \(error)")
        }
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
