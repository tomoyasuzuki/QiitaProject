//
//  UserProfileViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/07.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift

class UserProfileViewModel {
    let api = API()
    
    // viewControllerから渡してもらう
    let acccessToken: String = ""
    
    /*
 
     本来はpathを変更すればメソッドの数を減らせるのでそうするべきかも
 
    */
    
    // ユーザープロフィール
    func fetchUserProfile() -> Single<Data>{
        return api.call(path: API.Path.users.rawValue + "/userid")
    }
    // ユーザーのフォローユーザー
    func fetchUserFollower() -> Single<Data>{
        return api.call(path: "")
    }
    // ユーザーのフォロワー
    func fetchUserFollowee() -> Single<Data>{
        return api.call(path: "")
    }
    // ユーザーがストックしている記事
    func fetchUserStockItems() -> Single<Data> {
        return api.call(path: "")
    }
}
