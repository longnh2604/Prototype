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
    var menuOptions = ["Home", "New", "Help", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTestNavi = kMain_Storyboard.instantiateViewController(withIdentifier: "PageTestNavi") as? UINavigationController
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
    
    func changeViewController(_ index : Int) {
        switch index {
        case 0:
            self.slideMenuController()?.changeMainViewController(mainNavi!, close: true)
            break
        case 1:
            self.slideMenuController()?.changeMainViewController(pageTestNavi!, close: true)
            break
        case 2:
            self.slideMenuController()?.changeMainViewController(pageTestNavi!, close: true)
//            if (requestNavi == nil){
//                if let requestVC = kRequest_storyboard.instantiateViewController(withIdentifier: "RequestWaiterViewController") as? RequestWaiterViewController{
//                    requestNavi = UINavigationController(rootViewController: requestVC)
//                }
//            }
//            self.slideMenuController()?.changeMainViewController(requestNavi!, close: true)
            break
        case 3:
            slideMenuVC.dismiss(animated: true, completion: nil)
            break
        default:
            toggleLeft()
            //            callUpdateAllTable()
            break
        }
    }

}
