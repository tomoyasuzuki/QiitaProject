//
//  UserProfileRequest.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire

struct AuthenticatedUserProfileRequest: RequestProtocol {
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    var accessToken: String = ""
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/users/\(accessToken)/"
    }
}

