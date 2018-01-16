//
//  CustomerCell.swift
//  Prototype2
//
//  Created by Long on 2018/01/16.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {
    
    @IBOutlet weak var imvCustomer: UIImageView!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblCustomerSex: UILabel!
    @IBOutlet weak var lblCustomerID: UILabel!
    @IBOutlet weak var lblLstCome: UILabel!
    @IBOutlet weak var lblInbox: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblOpen: UILabel!
    @IBOutlet weak var lblUnopen: UILabel!
    @IBOutlet weak var btnInbox: UIButton!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var btnUnopen: UIButton!
    @IBOutlet weak var btnError: UIButton!
    
    func configure(with customer: CustomerData) {
        lblCustomerName.text = customer.cusName + "様"
        lblCustomerID.text = "ID : " + customer.cusID
        lblCustomerSex.text = customer.cusSex
        lblLstCome.text = "最新来店日　:" + customer.cusLstCome
        
        if let url = URL.init(string: customer.cusImage) {
            imvCustomer.downloadedFrom(url: url)
            imvCustomer.roundImage(with: imvCustomer)
        }
        
        //mailbox
        if customer.cusMailInbox != 0 {
            lblInbox.text = String(customer.cusMailInbox)
        } else {
            lblInbox.isHidden = true
        }
        
        if customer.cusMailOpen != 0 {
            lblOpen.text = String(customer.cusMailOpen)
        } else {
            lblOpen.isHidden = true
        }
        
        if customer.cusMailUnopen != 0 {
            lblUnopen.text = String(customer.cusMailUnopen)
        } else {
            lblUnopen.isHidden = true
        }
        
        if customer.cusMailError != 0 {
            lblError.text = String(customer.cusMailError)
        } else {
            lblError.isHidden = true
        }
    }
}
