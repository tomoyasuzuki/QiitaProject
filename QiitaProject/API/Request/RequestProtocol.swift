//
//  RequestProtocol.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import Alamofire

protocol RequestProtocol {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: JSONEncoding { get }
}

extension RequestProtocol {
    var baseURL: String {
        return "https://qiita.com/api/v2"
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var encoding: JSONEncoding {
        return JSONEncoding.default
    }
}
