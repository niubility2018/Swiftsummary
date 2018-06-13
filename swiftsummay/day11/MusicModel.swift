//
//  SectionModel.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/6/12.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import Differentiator

struct MusicModel {
    var model: String //歌名
    var items: [Item] //演唱者
}

extension MusicModel : AnimatableSectionModelType {
    typealias Item = Double
    
    var identity: String {
        return model
    }
    
    init(original: MusicModel, items: [Item]) {
        self = original
        self.items = items
    }
}


//class SectionModel: NSObject {
//
//}
