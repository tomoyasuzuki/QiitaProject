//
//  APIClient.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/06/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import Alamofire

class API {
    static let baseURL = "https://qiita.com/api/v2"
    static let clientId = "956b371103c3679441aee2b897bdf94eb6d28be8"
    static let clientSecret = "3f3fc429c399fbed68340b6a5d1c75d2ed877ac9"
    static let redirectURL = "https://www.tomonariSuzukiredirect.com"
    
    func call<T: RequestProtocol>(_ request: T) -> Single<Any> {
        return Single.create { (observer) -> Disposable in
            let disposeBag = Disposables.create()
            let url = URL(string: "\(request.baseURL)" + "\(request.path)")!
            print(url)
            Alamofire.request(url, method: request.method, parameters: request.parameters)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        observer(.error(error))
                    }
            }
            return disposeBag
        }
    }
}
