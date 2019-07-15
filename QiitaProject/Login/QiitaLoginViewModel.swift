//
//  QiitaLoginViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/06.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class QiitaLoginViewModel {
    let api = API()
    
    let acceessTokenRelay: PublishRelay<String> = PublishRelay<String>()
    var accessTokenObservable: Observable<String> { return acceessTokenRelay.asObservable() }
    
    func getAccessToken() -> Observable<Void> {
        return api.call(AccessTokenRequest(code: UserDefaults.standard.string(forKey: "authCode")!))
            .asObservable()
            .do(onNext: { response in
                print(response.request)
            })
            .map { response in try! JSONDecoder().decode(Token.self, from: response.data!) }
            .do(onNext: { token in
                self.acceessTokenRelay.accept(token.token)
                print("find token: \(token.token)")
                UserDefaults.standard.setValue(token.token, forKey: "accessToken")
            })
            .map { _ in () }
    }
}

