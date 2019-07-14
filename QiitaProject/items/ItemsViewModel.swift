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
    
    // - Main Method
    
    func fetchItems(observable: Observable<String>) -> Observable<[Item]> {
        return observable
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { $0.count >= 2 }
            .do { self.isLoadingRelay.accept(true) }
            .flatMap { self.api.call(ItemsRequest(query: $0,page: self.page, perPage: 10)) }
            .asObservable()
            .do (onNext: { response in
                self.countUpPage(response: response)
            })
            .map { response in return try! JSONDecoder().decode([Item].self, from: response.data!)}
            .do(onNext: { items in
                self.items = items
            }
        )
    }
    
    func fetchMoreItems(isLastCellObservable: Observable<Bool>, observable: Observable<String>) -> Observable<[Item]> {
        return Observable
            .combineLatest(isLastCellObservable, observable)
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { (boolen, string) in string.count >= 2 }
            .do { self.isLoadingRelay.accept(true) }
            .flatMap({ (boolen, string) -> Observable<[Item]> in
                //TODO: isLastCellObservable が　false の時は APIを叩かないようにする
                print(boolen)
                return self.api.call(ItemsRequest(query: string, page: self.page, perPage: 10))
                    .asObservable()
                    .map { response in try! JSONDecoder().decode([Item].self, from: response.data!)}
                }
            )
            .do(onNext: { items in self.items = items } )
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
