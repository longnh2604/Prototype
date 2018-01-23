//
//  CarteVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import PopupDialog
import Firebase
import RealmSwift

class CarteVC: UIViewController {

    var selectedIndexPath: NSIndexPath?
    var cellSelectedColor = UIColor(red: 188.0/255.0, green: 237.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
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
    var cartesData: Results<CarteData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(receive_data!["cusID"] ?? 1)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tblCarte.delegate = self
        tblCarte.dataSource = self
        
        let realm = RealmServices.shared.realm
        cartesData = realm.objects(CarteData.self)
        
        print("Receive data from CustomerVC \(String(describing: receive_data ?? nil))")
        getCustomersfromUser()
        if (pass_data_callback != nil){
            pass_data_callback!(["test":"data_test_CarteVC"])
        } else {
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let realm = RealmServices.shared.realm
        let result = realm.objects(CarteData.self)
        do {
            try realm.write {
                realm.delete(result)
            }
        } catch {
            print(error)
        }
    }
    
    func getCustomersfromUser() {
        queryRef.child("cartes").queryOrdered(byChild: "cusID").queryEqual(toValue: receive_data!["cusID"]!).observeSingleEvent(of: .value, with: { (snapshot) in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else {
                    return
                }
                print(dictionary)
                
                let carteID = dictionary["carteID"] as? Int
                let cusID = dictionary["cusID"] as? String
                let carteMemo = dictionary["carteMemo"] as? String
                let cusLstCome = dictionary["cusLstCome"] as? String
                let carteMemo1 = dictionary["carteMemo1"] as? String
                let carteMemo2 = dictionary["carteMemo2"] as? String
                
                let carte = CarteData()
                
                if dictionary["carteImage"] != nil {
                    if let carteImages = dictionary["carteImage"] as? [String]{
                        for image in carteImages{
                            carte.carteImages.append(image)
                        }
                    }
                }
                
                carte.carteID = carteID!
                carte.carteMemo = carteMemo!
                carte.cusID = cusID!
                carte.cusLstCome = cusLstCome!
                carte.carteMemo1 = carteMemo1!
                carte.carteMemo2 = carteMemo2!

                RealmServices.shared.create(carte)
                self.tblCarte.reloadData()
            }
        })
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

extension CarteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellCarte") as? CarteTableViewCell else
        { return UITableViewCell() }
        
        let carteCell = cartesData[indexPath.row]
        cell.configure(with: carteCell)
        
        if self.selectedIndexPath == indexPath as NSIndexPath {
            cell.contentView.backgroundColor = self.cellSelectedColor
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(cartesData.count)
        return cartesData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath as NSIndexPath {
            //selected same cell -> deselect
            selectedIndexPath = indexPath as NSIndexPath
        }else{
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath as NSIndexPath
            // refresh old cell to clear old selection indicators
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath as IndexPath) {
                    self.configure(cell: previousSelectedCell as! CarteTableViewCell, forRowAtIndexPath: previousSelectedIndexPath as IndexPath)
                }
            }
        }
        let selectedCell = tableView.cellForRow(at: indexPath)
        configure(cell: selectedCell as! CarteTableViewCell, forRowAtIndexPath: indexPath)
    }

    func configure(cell: CarteTableViewCell,forRowAtIndexPath indexPath:IndexPath) {
        DispatchQueue.main.async {
            if self.selectedIndexPath == indexPath as NSIndexPath {
                cell.contentView.backgroundColor = self.cellSelectedColor
            }else{
                cell.contentView.backgroundColor = UIColor.clear
            }
        }
    }
}
