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
        //Check Login session
        if UserDefaults.standard.string(forKey: "LoginState") == "logined" {
            userLogin()
        }
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
        SVProgressHUD.show()
        userLogin()
    }
    
    //MARK: - Load Data
    /***************************************************************/
    
    //Firebase Account Authentication
    func userLogin() {
        let cusEmail = "longnh264@gmail.com"
        let cusPassword = "123456"
        Auth.auth().signIn(withEmail: cusEmail , password: cusPassword) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            } else {
                print("Firebase Auth passed!")
                UserDefaults.standard.set(cusPassword, forKey: "userPassword")
                self.getAppNotify()
                self.findUser()
                self.getHelpData()
            }
        }
    }
    
    func getAppNotify() {
        queryRef.child("appnotify").observeSingleEvent(of: .value, with: { (snapshot) in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else {
                    return
                }
                print(dictionary)
                let notiID = dictionary["notiID"] as? Int
                let version = dictionary["version"] as? String
                let news = dictionary["news"] as? String
                let content = dictionary["content"] as? String
                
                let newNoti = AppNotify()
                newNoti.notiID = notiID!
                newNoti.notiVersion = version!
                newNoti.notiNews = news!
                newNoti.notiContent = content!
                
                RealmServices.shared.create(newNoti)
            }
        })
    }
    
    func getHelpData() {
        queryRef.child("apphelp").observeSingleEvent(of: .value, with: { (snapshot) in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else {
                    return
                }
                print(dictionary)
                let helpID = dictionary["helpID"] as? Int
                let helpTitle = dictionary["helpTitle"] as? String
                let helpImage = dictionary["helpImage"] as? String
                
                let newHelp = HelpData()
                newHelp.helpID = helpID!
                newHelp.helpTitle = helpTitle!
                newHelp.helpImage = helpImage!
                
                RealmServices.shared.create(newHelp)
            }
        })
    }
    
    func findUser() {
        let userID = Auth.auth().currentUser?.uid
        queryRef.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                return }
            print(snapshot.value!)
            
            //save user data
            UserDefaults.standard.set(snapshot.childSnapshot(forPath: "username").value, forKey: "username")
            UserDefaults.standard.set(snapshot.childSnapshot(forPath: "imageURL").value, forKey: "imageURL")
            UserDefaults.standard.set(snapshot.childSnapshot(forPath: "rules").value, forKey: "rules")
            
            //get Customer
            self.getCustomersfromUser(with: userID!)
        })
    }
    
    func getCustomersfromUser(with UID:String) {
        // create searchRef or queryRef you name it
        queryRef.child("customers").queryOrdered(byChild: "userID").queryEqual(toValue: UID).observeSingleEvent(of: .value,with: { (snapshot) in
            UserDefaults.standard.set(snapshot.childrenCount, forKey: "cusTotal")
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else {
                    return
                }
                let name = dictionary["cusName"] as? String
                let id = dictionary["cusID"] as? String
                let birth = dictionary["cusBirth"] as? String
                let image = dictionary["cusImage"] as? String
                let secret = dictionary["cusSecret"] as? String
                let userID = dictionary["userID"] as? String
                let sex = dictionary["cusSex"] as? String
                let lstCome = dictionary["cusLstCome"] as? String
                let mail = dictionary["cusMail"]?["inbox"] as? Int
                let open = dictionary["cusMail"]?["open"] as? Int
                let unopen = dictionary["cusMail"]?["unopen"] as? Int
                let error = dictionary["cusMail"]?["error"] as? Int
                let cusRegister = dictionary["registerDate"] as? String
                let memo = dictionary["cusMemo"] as? String
                let bloodtype = dictionary["cusBloodType"] as? String
                let hobby = dictionary["cusHobby"] as? String
                let note = dictionary["cusNote"] as? String
                
                let newCustomer = CustomerData()
                newCustomer.cusName = name!
                newCustomer.cusID = id!
                newCustomer.cusBirth = birth!
                newCustomer.cusImage = image!
                newCustomer.cusSecret = secret!
                newCustomer.userID = userID!
                newCustomer.cusSex = sex!
                newCustomer.cusLstCome = lstCome!
                newCustomer.cusMailInbox = mail!
                newCustomer.cusMailOpen = open!
                newCustomer.cusMailUnopen = unopen!
                newCustomer.cusMailError = error!
                newCustomer.cusRegisterDate = cusRegister!
                newCustomer.cusMemo = memo!
                newCustomer.cusBloodType = bloodtype!
                newCustomer.cusHobby = hobby!
                newCustomer.cusNote = note!
                
                RealmServices.shared.create(newCustomer)
            }
            self.present(slideMenuVC, animated: true, completion: nil)
            SVProgressHUD.dismiss()
            })
    }
    
    //Get the CloudKit Database
//    func loadCloudDatabase(){
//
//        let container = CKContainer.default()
//        let privateDB = container.privateCloudDatabase
//        let predicate = NSPredicate(value: true)
//        let zone = CKRecordZone(zoneName: "PrototypeZone")
//
//        let query = CKQuery(recordType: "customerData", predicate: predicate)
//
//        privateDB.perform(query, inZoneWith: zone.zoneID) { (results, error) -> Void in
//            if error != nil {
//                print(error!)
//                SVProgressHUD.showError(withStatus: error?.localizedDescription)
//                return
//            }
//
//            OperationQueue.main.addOperation({ () -> Void in
//                if self.realm.isEmpty {
//                    for result in results! {
//                        let newCustomer = CustomerData()
//                        newCustomer.cusName = result.value(forKey: "cusName") as! String
//                        newCustomer.cusID = result.value(forKey: "cusID") as! String
//                        newCustomer.cusSex = result.value(forKey: "cusSex") as! String
//                        newCustomer.cusLstCome = result.value(forKey: "cusLstCome") as? Date
//                        newCustomer.cusBirth = result.value(forKey: "cusBirth") as? Date
//                        newCustomer.cusMailInbox = result.value(forKey: "cusMailInbox") as! Int
//                        newCustomer.cusMailOpen = result.value(forKey: "cusMailOpen") as! Int
//                        newCustomer.cusMailError = result.value(forKey: "cusMailError") as! Int
//                        newCustomer.cusMailUnopen = result.value(forKey: "cusMailUnopen") as! Int
//                        newCustomer.cusCarte.append(String(describing: result["carte"]))
//                        self.save(customer: newCustomer)
//                    }
//                }
//
//                SVProgressHUD.dismiss()
//                self.performSegue(withIdentifier: "goToMainPage", sender: nil)
//            })
//        }
//    }
    
    
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
