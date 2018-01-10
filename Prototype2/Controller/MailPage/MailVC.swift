//
//  MailVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class MailVC: UIViewController {
    
    @IBOutlet weak var tblMailCategory: UITableView!
    @IBOutlet weak var tblMail: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add gesture swipe left to dismiss
        let slideRight = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideRight.direction = .right
        view.addGestureRecognizer(slideRight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNewCategoryPressed(_ sender: Any) {
        
    }
    
}
