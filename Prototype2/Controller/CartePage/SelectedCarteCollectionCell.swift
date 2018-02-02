//
//  SelectedCarteCollectionCell.swift
//  Prototype2
//
//  Created by Long on 2018/01/24.
//  Copyright © 2018 Long. All rights reserved.
//

import UIKit

class SelectedCarteCollectionCell: UICollectionViewCell {
    
    // IBOutlet
    @IBOutlet weak var imvCarte: UIImageView!
    @IBOutlet weak var lblCellNo: RoundLabelCorner!
    
    override var isSelected: Bool {
        didSet {
            
            if isSelected {
//                backgroundColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:1.0)
                layer.borderWidth = 2.0
                layer.borderColor = UIColor(red:56/255, green:192/255, blue:201/255, alpha:1.0).cgColor
            } else {
//                backgroundColor = UIColor(red:26/255, green:26/255, blue:26/255, alpha:0.4)
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}
