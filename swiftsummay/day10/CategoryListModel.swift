//
//  CategoryListModel.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/4/18.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import HandyJSON
class CategoryListModel: HandyJSON {
    var sumCount: Int32!
    var sumPage: Int32!
    var currentPage: Int!
    var type: Int32!
    var id: Int32!
    var pageTitle:String?
    var keyStr: String?
    var gushiwens: Array<GuShiWen>?
    var masterTitle: String?
    
    required init() {
    }
}
