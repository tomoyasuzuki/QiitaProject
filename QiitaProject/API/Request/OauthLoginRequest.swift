//
//  OauthLogin.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire

struct OauthLoginRequest: RequestProtocol {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/oauth/authorize"
    }
    
    var parameters: Parameters? {
        return ["client_id": APIConstant.clientId, "scope": "read_qiita"]
    }
}
