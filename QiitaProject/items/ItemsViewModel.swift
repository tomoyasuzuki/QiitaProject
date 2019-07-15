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
import Alamofire

class ItemsViewModel {
    
    // - Property
    
    let api = API()
    var items: [Item] = []
    var enableFetchMoreItems: Bool = true
    var page: Int = 1
    
    let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var isLoadingObservable: Observable<Bool> { return isLoadingRelay.asObservable() }
    
    let fetchItemRelay: PublishRelay<[Item]> = PublishRelay<[Item]>()
    var fetchItemObservable: Observable<[Item]> { return fetchItemRelay.asObservable() }
    
    let fetchMoreItemRelay: PublishRelay<[Item]> = PublishRelay<[Item]>()
    var fetchMoreItemObservable: Observable<[Item]> { return fetchMoreItemRelay.asObservable() }
    
    // - Main Method
    
    func fetchItems(observable: Observable<String>) -> Observable<Void> {
        return observable
            .do { self.isLoadingRelay.accept(true) }
            .flatMap { self.api.call(ItemsRequest(query: $0,page: self.page, perPage: 10)) }
            .do (onNext: { response in
                self.countUpPage(response: response)
            })
            .map { response in try! JSONDecoder().decode([Item].self, from: response.data!)}
            .do(onNext: { items in
                self.items = items
                self.fetchItemRelay.accept(self.items)
            })
            .map { _ in ()}
    }
    
    func fetchMoreItems(isLastCellObservable: Observable<Bool>, observable: Observable<String>) -> Observable<Void> {
        return Observable
            .combineLatest(isLastCellObservable, observable)
            .do { self.isLoadingRelay.accept(true) }
            .flatMap({ (boolen, string) in
                //TODO: boolen が　false の時は APIを叩かないようにする
                return self.api.call(ItemsRequest(query: string, page: self.page, perPage: 10))
            })
            .map { response in try! JSONDecoder().decode([Item].self, from: response.data!)}
            .do(onNext: {
                items in self.items = items
                self.fetchMoreItemRelay.accept(self.items)
            })
            .map { _ in ()}
    }
}

// change variable state

extension ItemsViewModel {
    private func changeEnableFetchItemsState(enableFetchMoreItems: Bool) {
        self.enableFetchMoreItems = enableFetchMoreItems
    }
    
    private func countUpPage(response: DataResponse<Data>) {
        if let header = response.response?.allHeaderFields["Link"] as? String {
            if header.contains("rel=\"next\"") {
                print("incriment page:\(page) -> \(page + 1)")
                self.page += 1
                
                changeEnableFetchItemsState(enableFetchMoreItems: true)
            } else {
                changeEnableFetchItemsState(enableFetchMoreItems: false)
            }
        }
    }
}
