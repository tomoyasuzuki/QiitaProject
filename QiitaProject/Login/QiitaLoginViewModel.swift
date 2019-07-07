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
    // oauth画面へ遷移する際のURL(クライアントによって一意なので変数として保持する)
    var oauthURL: URLRequest {
        return api.oauthURL
    }
    
    func getAccessToken(authCode: String) -> Observable<Token> {
        return api.call(path: API.Path.acceessToken.rawValue, method: .post, parameters: API.QiitaParameters.getToken(code: authCode).params)
            .asObservable()
            .map { data in self.toToken(data: data)}
            .do(onNext: { token in
                self.accessToken = token.token
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
