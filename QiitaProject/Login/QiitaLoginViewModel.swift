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

    func getAccessToken() -> Observable<Token>? {
        guard let authCode = UserDefaults.standard.string(forKey: "authCode") else { return nil }
        
        return api.call(AccessTokenRequest(code: authCode))
            .asObservable()
            .map { data in try! JSONDecoder().decode(Token.self, from: data) }
            .do(onNext: { token in
                print("find token: \(token.token)")
                UserDefaults.standard.setValue(token.token, forKey: "accessToken")
            }
        )
    }
}

