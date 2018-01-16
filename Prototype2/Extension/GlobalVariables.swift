//
//  GlobalVariables.swift
//  Prototype2
//
//  Created by Long on 2018/01/16.
//  Copyright © 2018 Long. All rights reserved.
//

import Foundation

class GlobalVariables {
    public var relationID:String = ""
//    public var cusRecord:Array<CKRecord> = []
    public var cellIndex:Int = 0
    public var cellCarteIndex:Int = 0
    
    class var sharedManager: GlobalVariables {
        struct Static{
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
    
    func clearData() {
//        cusRecord.removeAll()
    }
}
