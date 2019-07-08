//
//  ItemsRequest.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import Alamofire

struct ItemsRequest: RequestProtocol {
    
    init(query: String) {
        self.query = query
    }
    
    var query: String = ""
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/items"
    }
    
    var parameters: Parameters? {
        return ["query": "\(query)"]
    }
}
