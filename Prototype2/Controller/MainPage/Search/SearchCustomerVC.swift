//
//  SearchCustomerVC.swift
//  Prototype2
//
//  Created by Long on 2018/01/22.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit
import RealmSwift

class SearchCustomerVC: UIViewController {

    @IBOutlet weak var tblSearch: UITableView!

    var customers: Results<CustomerData>!
    var selectedIndexPath: NSIndexPath?
    var cellSelectedColor = UIColor(red: 188.0/255.0, green: 237.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblSearch.delegate = self
        tblSearch.dataSource = self
        
        let realm = RealmServices.shared.realm
        customers = realm.objects(CustomerData.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchCustomerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell") as? CustomerCell else
        { return UITableViewCell() }
        
        let customerCell = customers[indexPath.row]
        cell.configure(with: customerCell)
        
        if self.selectedIndexPath == indexPath as NSIndexPath {
            cell.contentView.backgroundColor = self.cellSelectedColor
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(String(describing: selectedIndexPath?.row)) indexpath \(String(indexPath.row))")
        if selectedIndexPath == indexPath as NSIndexPath {
            //selected same cell -> deselect
            selectedIndexPath = indexPath as NSIndexPath
        }else{
            let oldSelectedIndexPath = selectedIndexPath
            selectedIndexPath = indexPath as NSIndexPath
            // refresh old cell to clear old selection indicators
            if let previousSelectedIndexPath = oldSelectedIndexPath {
                if let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath as IndexPath) {
                    self.configure(cell: previousSelectedCell as! CustomerCell, forRowAtIndexPath: previousSelectedIndexPath as IndexPath)
                }
            }
        }
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        if selectedCell != nil {
            configure(cell: selectedCell as! CustomerCell, forRowAtIndexPath: indexPath)
        }
    }
    
    func configure(cell: CustomerCell,forRowAtIndexPath indexPath:IndexPath) {
        DispatchQueue.main.async {
            if self.selectedIndexPath == indexPath as NSIndexPath {
                cell.contentView.backgroundColor = self.cellSelectedColor
            }else{
                cell.contentView.backgroundColor = UIColor.clear
            }
        }
    }
}
