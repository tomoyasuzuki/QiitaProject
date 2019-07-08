//
//  UserProfileViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/07.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserProfileViewModel {
    let api = API()
    
    // viewControllerから渡してもらう
    let acccessToken: String = ""
    
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private var isLoadingObservable: Observable<Bool> { return self.isLoadingRelay.asObservable() }
    // ユーザープロフィール
    func fetchUserProfile() -> Observable<SpecifiedUser> {
        return api.call(UserProfileRequest())
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in self.toUser(data: data) }
    }
    
    // ユーザーがフォローしているタグ
    func fetchUserFolloingTags() -> Observable<[ItemTag]> {
        return api.call(UserProfileRequest())
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in self.toItemTag(data: data) }
    }
    
    // ユーザーがストックしている記事
    func fetchUserStockItems() -> Observable<[Item]> {
        return api.call(UserProfileRequest())
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in self.toItem(data: data) }
    }
    
    // デコード処理
    func toUser(data: Data) -> SpecifiedUser {
        var items: SpecifiedUser {
            return try! JSONDecoder().decode(SpecifiedUser.self, from: data)
        }
        return items
    }
    
    // デコード処理
    public func toItem(data: Data) -> [Item] {
        var items: [Item] {
            return try! JSONDecoder().decode([Item].self, from: data)
        }
        return items
    }
    
    // デコード処理
    public func toItemTag(data: Data) -> [ItemTag] {
        var items: [ItemTag] {
            return try! JSONDecoder().decode([ItemTag].self, from: data)
        }
        return items
    }
}
