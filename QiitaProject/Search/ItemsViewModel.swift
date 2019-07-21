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
    
    private let api = API()
    var items: [Item] = []
    private var enableFetchMoreItems: Bool = true
    private var page: Int = 1
    private var perPage: Int = 10
    
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var isLoadingObservable: Driver<Bool> { return isLoadingRelay.asDriver(onErrorDriveWith: Driver.empty()) }
    
    private let itemsRelay: PublishRelay<[Item]> = PublishRelay<[Item]>()
    var itemsObservable: Driver<[Item]> { return itemsRelay.asDriver(onErrorDriveWith: Driver.empty()) }
    
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
                self.itemsRelay.accept(self.items)
            })
            .map { _ in ()}
    }
    
    func fetchMoreItems(isLastCellObservable: Observable<Bool>, observable: Observable<String>) -> Observable<Void> {
        return Observable
            .combineLatest(isLastCellObservable, observable)
            .flatMap({ (isLastCell, query) in
                return self.api.call(ItemsRequest(query: query, page: self.page, perPage: self.perPage))
            })
            .map { response in try! JSONDecoder().decode([Item].self, from: response.data!)}
            .do(onNext: { items in
                self.addMoreItem(items: items)
                self.itemsRelay.accept(self.items)
            })
            .map { _ in ()}
    }
}

// change variable state

extension ItemsViewModel {
    private func countUpPage(response: DataResponse<Data>) {
        guard let _totalCount = response.response?.allHeaderFields["total-count"], let totalCount = _totalCount as? String else { return }
        let totalCountInt = Int(totalCount)!
        if totalCountInt <= self.items.count {
            self.enableFetchMoreItems = false
        } else {
            if (totalCountInt - self.items.count) < self.perPage {
                self.perPage = totalCountInt - self.items.count
            }
            
            print("incriment page:\(page) -> \(page + 1)")
            self.page += 1
            self.enableFetchMoreItems = true
        }
    }
}

extension ItemsViewModel {
    private func addMoreItem(items: [Item]) {
        for i in 0...items.count - 1 {
            self.items.insert(items[i], at: 0)
        }
    }
}
