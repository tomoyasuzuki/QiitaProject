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
import Alamofire

class QiitaLoginViewModel {
    
    let api = API()
    
    struct Output {
        let transition: Signal<Void>
    }
    
    func input(authCode: PublishRelay<String>) -> Output {
        let transition = authCode
                        .flatMap { [weak self] code -> Observable<DataResponse<Data>> in
                            guard let self = self else { return Observable.empty() }
                            return self.api.call(AccessTokenRequest(code: code)).asObservable() }
                        .map { response in try! JSONDecoder().decode(Token.self, from: response.data!) }
                        .do(onNext: { token in
                            UserDefaults.standard.set(token.token, forKey: "accessToken")
                        })
                        .map { _ in ()}
                        .asSignal(onErrorSignalWith: Signal.empty())
        
        return Output(transition: transition)
    }
}

