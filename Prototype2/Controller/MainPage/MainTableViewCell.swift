//
//  MainTableViewCell.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
