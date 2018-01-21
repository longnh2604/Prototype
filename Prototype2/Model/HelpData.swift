//
//  HelpData.swift
//  Prototype2
//
//  Created by Long Nguyen on 2018/01/21.
//  Copyright © 2018 Long. All rights reserved.
//

import Foundation
import RealmSwift

class HelpData: Object {
    @objc dynamic var helpID: Int = 0
    @objc dynamic var helpTitle: String = ""
    @objc dynamic var helpImage: String = ""
}
