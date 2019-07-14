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
        return "/access_tokens"
    }
    
    var parameters: Parameters? {
        return ["client_id": APIConstant.clientId, "client_secret": APIConstant.clientSecret, "code": code]
    }
}

