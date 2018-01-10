//
//  MainVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift
import CloudKit

class MainVC: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var tblMain: UITableView!
    @IBOutlet weak var lblCusTotal: UILabel!
    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var lblCusName: UILabel!
    @IBOutlet weak var lblCusSex: UILabel!
    @IBOutlet weak var lblCusId: UILabel!
    @IBOutlet weak var lblCusBirth: UILabel!
    @IBOutlet weak var lblCusLstCome: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnForward: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
                    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnForwardPressed(_ sender: Any) {
        tableViewScrollToBottom(animated: true)
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.tblMain.numberOfSections
            let numberOfRows = self.tblMain.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.tblMain.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    @IBAction func AddPersonPressed(_ sender: Any) {
        performSegue(withIdentifier:"goToNewUserPage", sender: self)
    }
    
    @IBAction func EditPersonPressed(_ sender: Any) {
        performSegue(withIdentifier:"goToUserPage", sender: self)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        let alert = UIAlertController(title: "内容を選択してください", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let searchDayCome = UIAlertAction(title: "来店日で検索", style: .default) { UIAlertAction in
            print("Take A New Picture")
        }
        let searchCusID = UIAlertAction(title: "お客様番号を表示", style: .default) { UIAlertAction in
            print("Select Photo From Device")
        }
        let searchBirth = UIAlertAction(title: "生年月日で検索", style: .default) { UIAlertAction in
            print("Select Photo Uploaded")
        }
        let searchMail = UIAlertAction(title: "メモで検索", style: .default) { UIAlertAction in
            print("Select Photo Uploaded")
        }
        let searchMailSent = UIAlertAction(title: "送信メールで検索", style: .default) { UIAlertAction in
            print("Select Photo Uploaded")
        }
        alert.addAction(cancel)
        alert.addAction(searchDayCome)
        alert.addAction(searchCusID)
        alert.addAction(searchBirth)
        alert.addAction(searchMail)
        alert.addAction(searchMailSent)
        alert.popoverPresentationController?.sourceView = self.btnSearch
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
        alert.popoverPresentationController?.sourceRect = self.btnSearch.bounds
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
