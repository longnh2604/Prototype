//
//  CarteVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import PopupDialog

class CarteVC: UIViewController {

    @IBOutlet weak var lblCusName: UILabel!
    @IBOutlet weak var lblCusLstCome: UILabel!
    @IBOutlet weak var lblCusMemo: UILabel!
    @IBOutlet weak var lblCusBirth: UILabel!
    @IBOutlet weak var lblCusBloodType: UILabel!
    @IBOutlet weak var lblCusHobby: UILabel!
    @IBOutlet weak var lblCusID: UILabel!
    @IBOutlet weak var tfCusNote: UITextField!
    @IBOutlet weak var tblCarte: UITableView!
    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var lblMailStatus: UILabel!
    
    var receive_data : [String:Any]?
    var pass_data_callback : (([String : Any])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Receive data from CustomerVC \(String(describing: receive_data ?? nil))")
        if (pass_data_callback != nil){
            pass_data_callback!(["test":"data_test_CarteVC"])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCartePressed(_ sender: Any) {
        
    }
    
    @IBAction func QRPressed(_ sender: Any) {
        openPopup(title: "ABCARTE QR コード \n\n",msg: "スマートフォンをお持ちの方は、QRコードアプリをダウンロードして頂く必要がございます。\n「＠abcarte.jp」からのドメインブロックを解除して下さい。\n3日以内に返信メールが届かなかった場合は、店舗へご連絡下さい。\n\nスタッフ様へ・このQRコードの有効期限は48時間です。48時間を過ぎた場合は、再度QRコードの作成をして下さい】")
    }
    
    func openPopup(title:String,msg:String) {
        // Prepare the popup assets
        // Create the dialog
        let popup = PopupDialog(title: title, message: msg, image:UIImage(named:"qrCode"))
        
        // This button will not the dismiss the dialog
        let button = DefaultButton(title: "OK", dismissOnTap: true) {
        }
        
        // to add a single button
        popup.addButton(button)
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        
    }
    
    @IBAction func btnSecretPressed(_ sender: Any) {
        
    }
    
    @IBAction func btnMailPressed(_ sender: Any) {
        
    }
}
