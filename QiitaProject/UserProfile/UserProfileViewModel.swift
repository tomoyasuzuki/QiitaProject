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
    
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    private var isLoadingObservable: Observable<Bool> { return self.isLoadingRelay.asObservable() }
    
    // 認証ユーザー取得
    func fetchUserProfile() -> Observable<AuthenticatedUser>? {
        guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return nil }
        
        return api.call(AuthenticatedUserProfileRequest(accessToken: accessToken))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { response in try! JSONDecoder().decode(AuthenticatedUser.self, from: response.data!)}
    }
    
    // フォローしているタグ取得
    func fetchUserFolloingTags() -> Observable<[ItemTag]>? {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return nil }
        
        return api.call(UserFollowingTagsRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { response in try! JSONDecoder().decode([ItemTag].self, from: response.data!) }
    }
    
    // ストック記事取得
    func fetchUserStockItems() -> Observable<[Item]>? {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return nil }
        
        return api.call(UserStocksRequest(userId: userId))
            .do {
                self.isLoadingRelay.accept(true)
            }
            .asObservable()
            .map { response in try! JSONDecoder().decode([Item].self, from: response.data!) }
    }
}
