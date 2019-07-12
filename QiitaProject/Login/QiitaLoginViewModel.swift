//
//  QiitaLoginViewModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/06.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift

class QiitaLoginViewModel {
    let api = API()
    // アクセストークンの保持
    var accessToken: String = ""
    
    func getAccessToken(authCode: String) -> Observable<Token> {
        return api.call(AccessTokenRequest(code: authCode))
            .asObservable()
            .map { data in try! JSONDecoder().decode(Token.self, from: data) }
            .do(onNext: { token in
                self.accessToken = token.token
            })
    }
}

