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
   
    struct Output {
        let userProfiles: Signal<(AuthenticatedUser,[ItemTag],[Item])>
    }
    
    func input() -> Output {
        
        var user: Observable<AuthenticatedUser> {
            guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return Observable.empty() }
            
            return api.call(AuthenticatedUserProfileRequest(accessToken: accessToken))
                .asObservable()
                .map { response in try! JSONDecoder().decode(AuthenticatedUser.self, from: response.data!)}
        }
        
        var tags: Observable<[ItemTag]> {
            guard let userId = UserDefaults.standard.string(forKey: "userId") else { return Observable.empty() }
            
            return api.call(UserFollowingTagsRequest(userId: userId))
                .asObservable()
                .map { response in try! JSONDecoder().decode([ItemTag].self, from: response.data!) }
        }
        
        var stockItmes: Observable<[Item]> {
            guard let userId = UserDefaults.standard.string(forKey: "userId") else { return Observable.empty() }
            
            return api.call(UserStocksRequest(userId: userId))
                .asObservable()
                .map { response in try! JSONDecoder().decode([Item].self, from: response.data!) }
        }
        

        let userProfiles = Observable
            .combineLatest(user, tags, stockItmes)
            .asSignal(onErrorSignalWith: Signal.empty())
        
        return Output(userProfiles: userProfiles)
    }
}
