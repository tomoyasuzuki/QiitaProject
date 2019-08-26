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
        let user: Signal<AuthenticatedUser>
        let tags: Signal<[ItemTag]>
        let stockItems: Signal<[Item]>
    }
    
    func input() -> Output {
        
        var user: Signal<AuthenticatedUser> {
            guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else { return Signal.empty() }
            print(accessToken)
            
            return api.call(AuthenticatedUserProfileRequest(accessToken: accessToken))
                .asObservable()
                .map { response in try! JSONDecoder().decode(AuthenticatedUser.self, from: response.data!)}
                .asSignal(onErrorSignalWith: Signal.empty())
        }
        
        var tags: Signal<[ItemTag]> {
            guard let userId = UserDefaults.standard.string(forKey: "userId") else { return Signal.empty() }
            
            return api.call(UserFollowingTagsRequest(userId: userId))
                .asObservable()
                .map { response in try! JSONDecoder().decode([ItemTag].self, from: response.data!) }
                .asSignal(onErrorSignalWith: Signal.empty())
        }
        
        var stockItmes: Signal<[Item]> {
            guard let userId = UserDefaults.standard.string(forKey: "userId") else { return Signal.empty() }
            
            return api.call(UserStocksRequest(userId: userId))
                .asObservable()
                .map { response in try! JSONDecoder().decode([Item].self, from: response.data!) }
                .asSignal(onErrorSignalWith: Signal.empty())
        }
        
        return Output(user: user, tags: tags, stockItems: stockItmes)
    }
}
