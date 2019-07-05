//
//  itemsAPI.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/01.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

class Decode {
    // デコード処理
    func toItem(data: Data) -> [Item] {
        return try! JSONDecoder().decode([Item].self, from: data)
    }
}
