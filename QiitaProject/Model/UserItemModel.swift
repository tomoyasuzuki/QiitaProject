//
//  UserItemModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

struct UserItem: Codable {
    let name: String?
    let profileImageUrl: String?
    
    init(name: String, profileImageUrl: String) {
        self.name = name
        self.profileImageUrl = profileImageUrl
    }
}
