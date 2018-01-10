//
//  CarteTableViewCell.swift
//  Prototype2
//
//  Created by Long on 2018/01/10.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class CarteTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var imvCus: UIImageView!
    @IBOutlet weak var lblLstComeDay: UILabel!
    @IBOutlet weak var lblMemo2: UILabel!
    @IBOutlet weak var lblMemo: UILabel!
    @IBOutlet weak var lblMemo1: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
