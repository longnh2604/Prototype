//
//  RoundImageCorner.swift
//  ABCarte2
//
//  Created by Long Nguyen on 2017/12/13.
//  Copyright © 2017 longnh. All rights reserved.
//

import UIKit
@IBDesignable

class RoundImageCorner:UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    func setup() {
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}
