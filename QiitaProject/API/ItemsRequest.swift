//
//  ItemsRequest.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import Alamofire

struct ItemsRequest: RequestProtocol {
    
    init(query: String, page: Int, perPage: Int){
        self.query = query
    }
    
    var query: String = ""
    
    var page: Int = 0
    
    var perPage: Int = 0
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/items"
    }
    
    var parameters: Parameters? {
        return ["query": "\(query)","page": page, "per_page": perPage]
    }
}
