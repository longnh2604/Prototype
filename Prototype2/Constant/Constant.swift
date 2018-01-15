//
//  Constant.swift
//  Prototype2
//
//  Created by Jonny Rice on 1/12/18.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Firebase

let kScreenSize: CGSize = UIScreen.main.bounds.size
//Main storyboard
let kMain_Storyboard = UIStoryboard(name: "Main", bundle: nil)
//Init SlideMenuVC
let mainTabbarController = kMain_Storyboard.instantiateViewController(withIdentifier: "idMainVC") as? MainVC
let naviMain = UINavigationController(rootViewController: mainTabbarController!)
let slideMenuVC = ExSlideMenuController(mainViewController:naviMain, leftMenuViewController: kLeftMenuVC!)
//Init LeftMenuVC
let kLeftMenuVC = kMain_Storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
//Database Ref
let queryRef = Database.database().reference()
