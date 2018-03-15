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
    static let provider = MoyaProvider<DouBan>()
    static func request(
        _ target: DouBan,
        success successCallBack: @escaping (JSON) -> Void,
        error errorCallBack: @escaping (Int) -> Void,
        failure failureCallBack: @escaping (MoyaError) -> Void
        ){
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do{
//                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successCallBack(json)
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

