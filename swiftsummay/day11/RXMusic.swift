//
//  RXMusic.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/6/12.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

struct RXMusic {
    let name: String //歌名
    let singer: String //演唱者
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

extension RXMusic: CustomStringConvertible{
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}

//class RXMusic: NSObject {
//
//}
