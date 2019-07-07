//
//  TokenModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/06.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
// MARK: - Token
struct Token: Codable {
    let clientID: String
    let clientSecret: String
    let token: String
}

