//
//  HeadPortrait.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/11.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import RealmSwift
//用户头像
class HeadPortrait: Object {
  @objc dynamic var data: Data?
  @objc dynamic var date = Date()
    
}
