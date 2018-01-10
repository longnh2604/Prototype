//
//  UserPopupVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class UserPopupVC: UIViewController {

    var isEdit:Bool = false
    var userIndex : Int = 0
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var switchMail: UISwitch!
    @IBOutlet weak var tfFName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfSeiName: UITextField!
    @IBOutlet weak var tfMeiName: UITextField!
    @IBOutlet weak var tfCusID: UITextField!
    @IBOutlet weak var tfCusBirth: UITextField!
    @IBOutlet weak var segGenre: UISegmentedControl!
    @IBOutlet weak var tfResponsible: UITextField!
    @IBOutlet weak var tfPostalCode: UITextField!
    @IBOutlet weak var tfPrefecture: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfAdditional1: UITextField!
    @IBOutlet weak var tfAdditional2: UITextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfHobby: UITextField!
    @IBOutlet weak var tfNote: UILabel!
    @IBOutlet weak var segLanguage: UISegmentedControl!
    @IBOutlet weak var btnConfirm: RoundButtonCorner!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnBloodType: RoundButtonCorner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        if isEdit == true{
            btnConfirm.setTitle("更　新", for:.normal)
        }else{
            btnConfirm.setTitle("登　録", for:.normal)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bloodTypePressed(_ sender: Any) {
        let alert = UIAlertController(title: "内容を選択してください", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let bloodA = UIAlertAction(title: "A 型", style: .default) { UIAlertAction in
            print("A 型")
        }
        let bloodB = UIAlertAction(title: "B　型", style: .default) { UIAlertAction in
            print("B　型")
        }
        let bloodO = UIAlertAction(title: "O 型", style: .default) { UIAlertAction in
            print("O 型")
        }
        let bloodAB = UIAlertAction(title: "AB 型", style: .default) { UIAlertAction in
            print("AB 型")
        }
        let bloodUndefined = UIAlertAction(title: "不明", style: .default) { UIAlertAction in
            print("不明")
        }
        alert.addAction(cancel)
        alert.addAction(bloodA)
        alert.addAction(bloodB)
        alert.addAction(bloodO)
        alert.addAction(bloodAB)
        alert.addAction(bloodUndefined)
        alert.popoverPresentationController?.sourceView = self.btnBloodType
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
        alert.popoverPresentationController?.sourceRect = self.btnBloodType.bounds
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addTransfer(_ sender: Any) {
        
    }
    
    @IBAction func genreSwitched(_ sender: Any) {
        
    }
    
    @IBAction func languageSwitched(_ sender: Any) {
        
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
        let alert = UIAlertController(title: "内容を選択してください", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let takeNew = UIAlertAction(title: "Take A New Picture", style: .default) { UIAlertAction in
            print("Take A New Picture")
        }
        let selectPhoto = UIAlertAction(title: "Select Photo From Device", style: .default) { UIAlertAction in
            print("Select Photo From Device")
        }
        let selectUpload = UIAlertAction(title: "Select Photo Uploaded", style: .default) { UIAlertAction in
            print("Select Photo Uploaded")
        }
        alert.addAction(cancel)
        alert.addAction(takeNew)
        alert.addAction(selectPhoto)
        alert.addAction(selectUpload)
        alert.popoverPresentationController?.sourceView = self.btnCamera
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
        alert.popoverPresentationController?.sourceRect = self.btnCamera.bounds
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - UIResponder Delegate
    /***************************************************************/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
