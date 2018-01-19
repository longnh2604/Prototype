//
//  AppNotify.swift
//  Prototype2
//
//  Created by Long on 2018/01/19.
//  Copyright © 2018 Long. All rights reserved.
//

import Foundation
import RealmSwift

class AppNotify: Object {
    @objc dynamic var notiID: Int = 0
    @objc dynamic var notiVersion: String = ""
    @objc dynamic var notiNews: String = ""
    @objc dynamic var notiContent: String = ""
}
