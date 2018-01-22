//
//  CarteData.swift
//  DBCollection
//
//  Created by Long on 2018/01/09.
//  Copyright © 2018 Long. All rights reserved.
//

import Foundation
import RealmSwift

class CarteData: Object {
    @objc dynamic var carteID: Int = 0
    @objc dynamic var carteMemo: String = ""
    @objc dynamic var cusID: String = ""
    var carteImages = List<String>()
}
