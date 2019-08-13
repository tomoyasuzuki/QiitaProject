//
//  TokenModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/06.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

struct AccessToken: Codable {
    let clientId: String
    let scopes: [String]
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case scopes
        case token
    }
}

