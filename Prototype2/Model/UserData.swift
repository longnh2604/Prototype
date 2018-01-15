//
//  UserData.swift
//  Prototype2
//
//  Created by Long on 2018/01/15.
//  Copyright © 2018 Long. All rights reserved.
//

import Foundation
import RealmSwift

class UserData: Object {
    @objc dynamic var userUID: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var userEmail: String = ""
    @objc dynamic var userPassword: String = ""
    @objc dynamic var userRules: String = ""
    @objc dynamic var userImage: String = ""
}
