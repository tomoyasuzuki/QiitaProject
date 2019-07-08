//
//  TokenModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/06.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

struct Token: Codable {
    let clientID: String
    let scopes: [String]
    let token: String
}

