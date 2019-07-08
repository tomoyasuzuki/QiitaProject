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
    func fetchUserProfile(userId: String) -> Observable<User> {
        return api.call(UserProfileRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in self.toUser(data: data) }
    }
    
    // ユーザーがフォローしているタグ
    func fetchUserFolloingTags(userId: String) -> Observable<[ItemTag]> {
        return api.call(UserProfileRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in self.toItemTag(data: data) }
    }
    
    // ユーザーがストックしている記事
    func fetchUserStockItems(userId: String) -> Observable<[Item]> {
        return api.call(UserProfileRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in self.toItem(data: data) }
    }
    
    // デコード処理
    func toUser(data: Data) -> User {
        var user: User {
            return try! JSONDecoder().decode(User.self, from: data)
        }
        return user
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
        var tags: [ItemTag] {
            return try! JSONDecoder().decode([ItemTag].self, from: data)
        }
        return tags
    }
}
