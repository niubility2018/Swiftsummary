//
//  TranslationModel.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/19.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import HandyJSON
class TranslationModel: HandyJSON {

    var id: Int?
    var nameStr: String?
    var author: String?
    var shiID: Int?
    var shiIDnew: String?
    var ok: Int?
    var noOk: Int?
    var cont: String?
    var cankao: String?
    var isYuanchuang: Bool?

    required init() {
    }
}
