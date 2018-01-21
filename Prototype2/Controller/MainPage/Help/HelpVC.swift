//
//  HelpVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/18.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

class HelpVC: UIViewController {

    @IBOutlet weak var tblHelp: UITableView!
    @IBOutlet weak var imvHelpInfo: UIImageView!
    
    var helpData: Results<HelpData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblHelp.delegate = self
        tblHelp.dataSource = self
        tblHelp.tableFooterView = UIView()
        
        let realm = RealmServices.shared.realm
        helpData = realm.objects(HelpData.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(index:Int) {
        if let url = URL.init(string: helpData[index].helpImage) {
            imvHelpInfo.downloadedFrom(url: url)
        }
    }

}

extension HelpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if helpData == nil {
            return 1
        }
        return helpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell") as? HelpCell else
        { return UITableViewCell() }
        
        cell.lblHelpTitle.text = helpData[indexPath.row].helpTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupUI(index: indexPath.row)
    }
}
