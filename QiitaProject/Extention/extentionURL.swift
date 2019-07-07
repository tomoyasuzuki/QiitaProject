//
//  extentionURL.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/07.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

// 下記記事を参照
// https://qiita.com/KosukeOhmura/items/8b65bdb63da6df95c7a3
/*
 
 同一キーなクエリを追加する必要がある場合
 String? 以外の型のまま追加したくなる場合
 には対応できないが今回は採用する
 
 */

extension URL {
    func withParams(name: String?, value: String?) -> URL? {
        guard let name = name, let value = value else { return nil}
        return self.queryItemAdded([URLQueryItem(name: name, value: value)])
    }
    
    func queryItemAdded(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return nil}
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url
    }
}
