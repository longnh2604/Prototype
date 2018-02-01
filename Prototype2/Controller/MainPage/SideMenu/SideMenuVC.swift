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

class SideMenuVC: UIViewController {

    // Variable
    var mainNavi : UINavigationController?
    var helpNavi : UINavigationController?
    var helpVC: HelpVC?
    var accountNavi: UINavigationController?
    var accountInfoVC: AccountInfoVC?
    var accountPopup: AccountInfoPopup?
    var menuOptions = ["ホーム", "ヘルプ", "ログアウト"]
    
    // IBOutlet
    @IBOutlet weak var tblSideMenu: UITableView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblLstLogined: UILabel!
    @IBOutlet weak var imvAccount: UIImageView!
    @IBOutlet weak var lblRole: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Load UI
    /***************************************************************/
    func setupUI() {
        tblSideMenu.tableFooterView = UIView()
        
        lblWelcome.text = "ようこそ、 　\(UserDefaults.standard.string(forKey: "username")!) 様"
        lblRole.text = UserDefaults.standard.string(forKey: "rules")!
        
        if let url = URL.init(string: UserDefaults.standard.string(forKey: "imageURL")!) {
            imvAccount.downloadedFrom(url: url)
            imvAccount.roundImage(with: imvAccount)
        }
        
        if let lstSignedin = UserDefaults.standard.string(forKey: "AppClose") {
            lblLstLogined.text = "直前のサインイン " + lstSignedin
        }
        
        helpNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "HelpNavi") as? UINavigationController
        helpVC = kMain_Storyboard.instantiateViewController(withIdentifier: "HelpVC") as? HelpVC
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
            DispatchQueue.main.async {
                mainTabbarController?.selectedIndex = 0
                self.getSelectedVCInTabbar()?.navigationController?.popToRootViewController(animated: true)
            }
            break
        case 1:
            getSelectedVCInTabbar()?.navigationController?.pushViewController(helpVC!, animated: true)
            break
        case 2:
            slideMenuVC.dismiss(animated: true, completion: nil)
            RealmServices.shared.deleteAll()
            break
        default:
            
            break
        }
        toggleLeft()
    }
}

//MARK: - Tableview Delegate, Datasource
/***************************************************************/
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
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
        changeViewController(indexPath.row)
    }
}
