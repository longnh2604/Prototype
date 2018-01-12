//
//  SideMenuVC.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/12.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblSideMenu: UITableView!
    var mainNavi : UINavigationController?
    var pageTestNavi : UINavigationController?
//    var newViewNavi : UINavigationController?
//    var helpViewNavi : UINavigationController?
    var pageTestVC : PageTestViewController?
    var menuOptions = ["Home", "New", "Help", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTestNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "PageTestNavi") as? UINavigationController
//        newViewNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "NaviNewView") as? UINavigationController
//        helpViewNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "NaviHelp") as? UINavigationController
        
        pageTestVC = kMain_Storyboard.instantiateViewController(withIdentifier: "PageTestViewController") as? PageTestViewController
        // Do any additional setup after loading the view.
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
//            if let help_vc = navi_help.viewControllers[0] as? HelpVC{
//
//            }else if let new_vc = navi_help.viewControllers[0] as? NewViewController{
//
//            }
        }
        return nil
    }
    
    
    func changeViewController(_ index : Int) {
        switch index {
        case 0:
//            self.slideMenuController()?.changeMainViewController(mainNavi!, close: true)
            getSelectedVCInTabbar()?.navigationController?.popToRootViewController(animated: true)
            break
        case 1:
//                if let navi_help = mainTabbarController?.viewControllers![(mainTabbarController?.selectedIndex)!] as? UINavigationController{
//                    if let help_vc = navi_help.viewControllers[0] as? HelpVC{
//                        help_vc.navigationController?.pushViewController(pageTestVC!, animated: true)
//                    }else if let new_vc = navi_help.viewControllers[0] as? NewViewController{
//                        new_vc.navigationController?.pushViewController(pageTestVC!, animated: true)
//                    }
//                }
            if !(UIApplication.topViewController() is PageTestViewController){
                getSelectedVCInTabbar()?.navigationController?.pushViewController(pageTestVC!, animated: true)
            }
            
            break
        case 2:
            if !(UIApplication.topViewController() is PageTestViewController){
                getSelectedVCInTabbar()?.navigationController?.pushViewController(pageTestVC!, animated: true)
            }
//            if let navi_help = mainTabbarController?.viewControllers![(mainTabbarController?.selectedIndex)!] as? UINavigationController{
//                if let help_vc = navi_help.viewControllers[0] as? HelpVC{
//                    help_vc.navigationController?.pushViewController(pageTestVC!, animated: true)
//                }else if let new_vc = navi_help.viewControllers[0] as? NewViewController{
//                    new_vc.navigationController?.pushViewController(pageTestVC!, animated: true)
//                }
//            }
            
            break
        case 3:
            slideMenuVC.dismiss(animated: true, completion: nil)
            break
        default:
            
            //            callUpdateAllTable()
            break
        }
        toggleLeft()
    }

}
