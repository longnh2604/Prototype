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
    
    func configure(with customer: CarteData) {
        
    }
}
