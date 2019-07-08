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
    
    func getAccessToken(authCode: String) {
        api.call(AccessTokenRequest(code: authCode))
            .asObservable()
            .map { data in self.toToken(data: data)}
            .do(onNext: { token in
                self.accessToken = token.token
                print("accesstoken: \(self.accessToken)")
            })
    }
}

private extension QiitaLoginViewModel {
    private func toToken(data: Data) -> Token {
        var token: Token {
             return try! JSONDecoder().decode(Token.self, from: data)
        }
        return token
    }
}
