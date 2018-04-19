//
//  Author.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/19.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import HandyJSON
class Author: HandyJSON {
    var id: Int!
    var idnew: String?
    var nameStr: String?
    var cont: String?
    var chaodai: String?
    var pic: String?
    var likes: Int?
    var ipStr: String?
    var creTime: CLongLong?
    var shiCount: Int?
    
    required init() {
    }
}
