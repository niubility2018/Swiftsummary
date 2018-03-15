//
//  HttpbinAPI.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/15.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import Moya
//初始化Httpbin.org请求的provider
let HttpbinProvider = MoyaProvider<Httpbin>()

public enum Httpbin {
    case ip
    case anything(String) //请求数据
}

extension Httpbin: TargetType{
    //服务器地址
    public var baseURL: URL {
        return URL(string: "http://httpbin.org")!
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .ip:
            return "/ip"
        case .anything(_):
            return "/anything"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .anything(let param1):
            var params:[String : Any] = [:]
            params["param1"] = param1
            params["param2"] = "2018"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
    
}


class HttpbinAPI: NSObject {

}
