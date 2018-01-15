//
//  SideMenuVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/12.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblSideMenu: UITableView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblLstLogined: UILabel!
    @IBOutlet weak var imvAccount: UIImageView!
    @IBOutlet weak var lblRole: UILabel!
    
    var mainNavi : UINavigationController?
    var pageTestNavi : UINavigationController?
    var pageTestVC : PageTestViewController?
    var menuOptions = ["ホーム", "口座情報", "言語", "ヘルプ", "ログアウト"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblSideMenu.tableFooterView = UIView()
        
        lblWelcome.text = "ようこそ、 　\(UserDefaults.standard.string(forKey: "username")!)"
        lblRole.text = UserDefaults.standard.string(forKey: "rules")!
        
        let url = URL(fileURLWithPath: UserDefaults.standard.string(forKey: "imageURL")!)
        if let data = try? Data(contentsOf: url)
        {
            let image: UIImage = UIImage(data: data)!
            imvAccount.image = image
        }
        
        let signInDate = Auth.auth().currentUser?.metadata.lastSignInDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss"
        lblLstLogined.text = dateFormatter.string(from: signInDate!)
        
        pageTestNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "PageTestNavi") as? UINavigationController
        pageTestVC = kMain_Storyboard.instantiateViewController(withIdentifier: "PageTestViewController") as? PageTestViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.lblTitle.text = menuOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: menuOptions[indexPath.row], sender: self)
        changeViewController(indexPath.row)
    }
    
    func getSelectedVCInTabbar() -> UIViewController?{
        if let navi_help = mainTabbarController?.viewControllers![(mainTabbarController?.selectedIndex)!] as? UINavigationController{
            return navi_help.viewControllers[0]
        }
        return nil
    }
    
    
    func changeViewController(_ index : Int) {
        switch index {
        case 0:
            getSelectedVCInTabbar()?.navigationController?.popToRootViewController(animated: true)
            break
        case 1:
            if !(UIApplication.topViewController() is PageTestViewController){
                getSelectedVCInTabbar()?.navigationController?.pushViewController(pageTestVC!, animated: true)
            }
            
            break
        case 2:
            if !(UIApplication.topViewController() is PageTestViewController){
                getSelectedVCInTabbar()?.navigationController?.pushViewController(pageTestVC!, animated: true)
            }
            break
        case 3:
            slideMenuVC.dismiss(animated: true, completion: nil)
            break
        default:
            
            break
        }
        toggleLeft()
    }

}
