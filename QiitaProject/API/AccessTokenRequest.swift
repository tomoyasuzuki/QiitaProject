//
//  AccessTokenRequest.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire

struct AccessTokenRequest: RequestProtocol {
    
    init(code: String) {
        self.code = code
    }
    
    var code: String = ""
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/access_token"
    }
    
    var parameters: Parameters? {
        return ["client_id": API.clientId, "client_secret": API.clientSecret, "code": code]
    }
}

