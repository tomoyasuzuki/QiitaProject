//
//  ItemsSearchViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//


import Foundation
import RxSwift

class ItemsViewModel {
    let api = API()
    var items: [Item] = []
    
    func fetchItems(observable: Observable<String>) -> Observable<[Item]> {
         return observable
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { $0.count >= 2 }
            .flatMap { self.api.call(path: API.Path.items.rawValue, parameters: API.QiitaParameters.query(query: $0, perPage: 100).params) }
            .map { data in self.toItem(data: data) }
            .do(onNext: { items in
                self.items = items
            })
    }
    
    // デコード処理
    func toItem(data: Data) -> [Item] {
        var items: [Item] {
            return try! JSONDecoder().decode([Item].self, from: data)
        }
        return items
    }
}
