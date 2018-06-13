//
//  MusicListViewModel.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/6/12.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import RxSwift

struct MusicListViewModel {
//    let data = Observable.just([
//        RXMusic(name: "无条件", singer: "陈奕迅"),
//        RXMusic(name: "你曾是少年", singer: "S.H.E"),
//        RXMusic(name: "从前的我", singer: "陈洁仪"),
//        RXMusic(name: "在木星", singer: "朴树"),
//        ])

    
    let items = Observable.just([
        MusicModel(model: "First section", items: [
            1.0,
            2.0,
            3.0
            ]),
        MusicModel(model: "Second section", items: [
            1.0,
            2.0,
            3.0
            ]),
        MusicModel(model: "Third section", items: [
            1.0,
            2.0,
            3.0
            ])
        ])
}

//class MusicListViewModel: NSObject {
//
//}

