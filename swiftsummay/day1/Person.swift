//
//  Person.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/30.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

protocol Person {
    //读写属性
    var name:String{get set}
    
    //只读属性
    var age:Int{get}
    
    //类型方法
    static func method1()
    
    //实例方法
    func method2() -> Int
    
    //突变方法
    mutating func method3()
}


//class Person: NSObject {
//
//}

