//
//  Network.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/15.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit

import Moya
import SwiftyJSON

struct Network {
    static let provider = MoyaProvider<Httpbin>()
    static func request(
        _ target: Httpbin,
        success successCallBack: @escaping (JSON) -> Void,
        error errorCallBack: @escaping (Int) -> Void,
        failure failureCallBack: @escaping (MoyaError) -> Void
        ){
        provider.request(target) { (result) in
            print(Moya.URL.self)
            switch result {
            case let .success(response):
                do{
                    //如果数据返回成功则直接将结果转为JSON
//                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    print("-------数据------------:",json)
                    successCallBack(json)
                }catch let error {
                    //如果数据获取失败，则返回错误状态码
                    errorCallBack((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                //如果连接异常，则返回错误信息（必要时还可以将尝试重新发起请求）
//                if target.shouldRetry {
//                    retryWhenReachable(target, successCallBack, errorCallBack,
//                                       failureCallBack)
//                }
//                else {
                    failureCallBack(error)
//                }
            }
        }
    }
    
    
    
    
    
    static func requestTool(
        _ target: Httpbin,
        success successCallBack: @escaping (NSDictionary) -> Void,
        error errorCallBack: @escaping (Int) -> Void,
        failure failureCallBack: @escaping (MoyaError) -> Void
        ){
        provider.request(target) { (result) in
            print(target)
            switch result {
            case let .success(response):
                do{
                    //如果数据返回成功则直接将结果转为JSON
                    let dict = try response.mapJSON()
                    
                    successCallBack(dict as! NSDictionary)
                }catch let error {
                    //如果数据获取失败，则返回错误状态码
                    errorCallBack((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                failureCallBack(error)

            }
        }
    }

    
    
    
    
}

