//
//  ItemsApi.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/13.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import Alamofire

class ItemsApi {
    let api = API()
    
    func toItemResponse(obsrevable: Observable<String>) -> Observable<[Item]>{
        return obsrevable
            .flatMap { self.api.call(ItemsRequest(query: $0, page: 1, perPage: 20)) }
            .map { response in
                let items = try! JSONDecoder().decode([Item].self, from: response.data!)
                if let header = response.response {
                    print(header)
                }
                return items
        }
    }
}
