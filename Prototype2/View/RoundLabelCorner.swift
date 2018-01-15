//
//  RoundLabelCorner.swift
//  ABCarte2
//
//  Created by Long on 2017/12/26.
//  Copyright © 2017 longnh. All rights reserved.
//

import UIKit
@IBDesignable

class RoundLabelCorner: UILabel {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }

}
