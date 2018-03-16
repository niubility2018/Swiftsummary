//
//  DouBanAPI.swift
//  swiftsummay
//
//  Created by xubojoy on 2018/3/15.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

import UIKit
import Moya

//初始化豆瓣FM请求的provider
let DouBanProvider = MoyaProvider<DouBan>()

//请求分类
public enum DouBan {
    case channels  //获取频道列表
    case playlist(String) //获取歌曲
}
//(string: "https://www.douban.com")!
//请求配置
extension DouBan: TargetType{
    //请求服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL.init(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        }
    }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .channels:
            return .get
        default:
            return .get
        }
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用）
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String : Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}



class DouBanAPI: NSObject {
   
    
}
