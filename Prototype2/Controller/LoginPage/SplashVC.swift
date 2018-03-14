//
//  SplashVC.swift
//  Prototype2
//
//  Created by Long on 2018/02/14.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class SplashVC: UIViewController {

    // Variable
    var customer: Results<CustomerData>!
    
    let animatedULogoView: AnimatedULogoView = AnimatedULogoView(frame: CGRect(x: 0.0, y: 0.0, width: 90.0, height: 90.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmServices.shared.realm
        customer = realm.objects(CustomerData.self)
        
        view.addSubview(animatedULogoView)
        animatedULogoView.layer.position = view.layer.position
        animatedULogoView.startAnimating()
        
        checkLoginState()
    }
    
    //Check Login session
    func checkLoginState() {
        if UserDefaults.standard.string(forKey: "LoginState") == "logined" {
            goToMainView()
        } else {
            delay(3.00) {
                self.goToLoginView()
            }
        }
    }
    
    func goToLoginView() {
        let loginPageView =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginPageView, animated: true, completion: nil)
    }
    
    func goToMainView() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            userLogin()
            group.leave()
        }
        
        group.notify(queue: .main) {
            delay(5.00) {
                self.present(slideMenuVC, animated: true, completion: nil)
            }
        }
    }

}
