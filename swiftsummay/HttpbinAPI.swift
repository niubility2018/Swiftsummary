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
    case channels  //获取频道列表
    case playlist(String) //获取歌曲
    case ocrParams(String)
    case shiwenlist(n:String, tstr:String, page:Int, pwd:String, id:Int, token:String )
    case shiwenDetail(idNew:String, token:String, random:Int)
}

//http://app.gushiwen.org/api/shiwen/shiwenv.aspx?id=f3d6556dbcad&token=gswapi&random=1626855374

extension Httpbin: TargetType{
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL.init(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        case .ocrParams(_):
            return URL(string: "https://apis.baidu.com")!
        case .shiwenlist(_),.shiwenDetail(_):
            return URL(string: "http://app.gushiwen.org")!
        default:
            return URL(string: "http://httpbin.org")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        case .ip:
            return "/ip"
        case .anything(_):
            return "/anything"
            
        case .ocrParams(_):
            return "/idl_baidu/baiduocrpay/idlocrpaid"
        case .shiwenlist(_):
            return "/api/shiwen/Default.aspx"
        case .shiwenDetail(_):
            return "/api/shiwen/shiwenv.aspx"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .channels,.playlist(_),.shiwenlist(_),.shiwenDetail(_):
            return .get
        default:
           return .post
        }
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String : Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .anything(let param1):
            var params:[String : Any] = [:]
            params["param1"] = param1
            params["param2"] = "2018"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .ocrParams(let imageStr):
            var params:[String:Any] = [:]
            params["fromdevice"] = "iPhone"
            params["clientip"] = "10.10.10.0"
            params["detecttype"] = "LocateRecognize"
            params["languagetype"] = "CHN_ENG"
            params["imagetype"] = "1"
            params["image"] = imageStr
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
//            n=1949558840&tstr=写雨&page=1&pwd=&id=0&token=gswapi
        case .shiwenlist(let n, let tstr, let page, let pwd, let id, let token):
            var params:[String:Any] = [:]
            params["n"] = n
            params["tstr"] = tstr
            params["page"] = page
            params["pwd"] = pwd
            params["id"] = id
            params["token"] = token
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .shiwenDetail(idNew: let idNew, token: let token, random: let random):
            var params:[String:Any] = [:]
            params["id"] = idNew
            params["token"] = token
            params["random"] = random
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .ocrParams(_):
            return ["apikey":"6f1ee4c3b91b4ece3705f5e2f071d968"]
        default:
            return nil
        }
        
    }
    
    
    
}


class HttpbinAPI: NSObject {

}
