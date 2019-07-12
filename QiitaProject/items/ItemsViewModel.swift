//
//  ItemsSearchViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

class ItemsViewModel {
    let api = API()
    var items: [Item] = []
    
    let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var isLoadingObservable: Observable<Bool> { return isLoadingRelay.asObservable() }
    
    func fetchItems(observable: Observable<String>) -> Observable<[Item]> {
         return observable
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { $0.count >= 2 }
            .flatMap { self.api.call(ItemsRequest(query: $0,page: 1, perPage: 20))}
            .do {
                self.isLoadingRelay.accept(true)
            }
            .map { data in try! JSONDecoder().decode([Item].self, from: data) }
            .do(onNext: { items in
                self.items = items
            })
    }
    
    func fetchMoreItems(isLastCell: Observable<Bool>, observable: Observable<String>) -> Observable<[Item]>? {
            return observable
                .debounce(0.5, scheduler: MainScheduler.instance)
                .filter { $0.count >= 2 }
                .flatMap { self.api.call(ItemsRequest(query: $0,page: 1, perPage: 20)) }
                .do {
                    self.isLoadingRelay.accept(true)
                    print("fetchmoreitems")
                }
                .map { data in try! JSONDecoder().decode([Item].self, from: data) }
                .do(onNext: { items in
                    self.items = items
                })
    }
}
