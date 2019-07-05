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
    
    func fetchItems(observable: Observable<String>) -> Observable<[Item]> {
         return observable
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { $0.count >= 2 }
            .flatMap { self.api.call(path: API.Path.items.rawValue, parameters: API.QiitaParameters.items(query: $0).params) }
            .map { data in self.toItem(data: data) }
    }
    
    // デコード処理
    func toItem(data: Data) -> [Item] {
        return try! JSONDecoder().decode([Item].self, from: data)
    }
}
