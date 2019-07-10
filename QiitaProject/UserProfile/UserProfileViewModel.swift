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
    
    let acccessToken: String = ""
    
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private var isLoadingObservable: Observable<Bool> { return self.isLoadingRelay.asObservable() }
    
    // 認証ユーザー取得
    func fetchUserProfile(accessToken: String) -> Observable<AuthenticatedUser> {
        return api.call(AuthenticatedUserProfileRequest(accessToken: accessToken))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in try! JSONDecoder().decode(AuthenticatedUser.self, from: data)}
    }
    
    // フォローしているタグ取得
    func fetchUserFolloingTags(userId: String) -> Observable<[ItemTag]> {
        return api.call(UserFollowingTagsRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in try! JSONDecoder().decode([ItemTag].self, from: data) }
    }
    
    // ストック記事取得
    func fetchUserStockItems(userId: String) -> Observable<[Item]> {
        return api.call(UserStocksRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { data in try! JSONDecoder().decode([Item].self, from: data) }
    }
}
