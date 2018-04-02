//
//  Chiken.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/30.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

protocol Animal {
    func move()
}

protocol Bird: Animal {
    func song()
}


class Chiken:Bird,Person {
    var name: String = ""
    
    var age: Int = 0
    
    static func method1() {
        
    }
    
    func method2() -> Int {
        return 3
    }
    
    func method3() {
        
    }
    

    func song() {
        
    }
    
    func move() {
        
    }
    
    
}
