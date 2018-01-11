//
//  CustomerData.swift
//  DBCollection
//
//  Created by Long on 2018/01/05.
//  Copyright © 2018 Long. All rights reserved.
//

import Foundation
import RealmSwift

class CustomerData: Object {
    @objc dynamic var cusName: String = ""
    @objc dynamic var cusID: String = ""
    @objc dynamic var cusBirth: Date?
    @objc dynamic var cusLstCome: Date?
    @objc dynamic var cusMailInbox: Int = 0
    @objc dynamic var cusMailOpen: Int = 0
    @objc dynamic var cusMailUnopen: Int = 0
    @objc dynamic var cusMailError: Int = 0
    @objc dynamic var cusSex: String = ""
    var cusCarte = List<String>()
}
