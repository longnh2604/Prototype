//
//  NotificationVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/19.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

class NotificationVC: UIViewController {

    @IBOutlet weak var tblNotify: UITableView!
    @IBOutlet weak var tvNotifyContent: UITextView!
    
    var notify: Results<AppNotify>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblNotify.delegate = self
        tblNotify.dataSource = self
        tblNotify.tableFooterView = UIView()
        
        let realm = RealmServices.shared.realm
        notify = realm.objects(AppNotify.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(index:Int) {
        let formattedString = NSMutableAttributedString()
        formattedString
            .bold("ABCARTE\n\n")
            .bold("APPVERSION : ")
            .normal(notify[index].notiVersion)
            .bold("\nNEWS : ")
            .normal(notify[index].notiNews)
            .bold("\nCONTENTS : ")
            .normal(notify[index].notiContent)
        tvNotifyContent.attributedText = formattedString
    }

}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notify == nil {
            return 1
        }
        return notify.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as? NotificationCell else
        { return UITableViewCell() }
        
        cell.lblNotify.text = notify[indexPath.row].notiNews
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupUI(index: indexPath.row)
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "Meiryo", size: 14)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
