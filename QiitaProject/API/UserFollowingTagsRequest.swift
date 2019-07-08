//
//  UserFollowingTagsRequest.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire

struct UserFollowingTagsRequest: RequestProtocol {
    
    init(userId: String) {
        self.userId = userId
    }
    
    var userId: String = ""
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/users/\(userId)/following_tags"
    }
}
