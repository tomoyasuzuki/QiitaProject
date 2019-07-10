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
    static let clientId: String = Resourses.string.clientId
    static let clientSecret: String = Resourses.string.clientSecret
    static let redirectURL: String = Resourses.string.redirectURL
    
    func call<T: RequestProtocol>(_ request: T) -> Single<Data> {
        return Single.create { (observer) -> Disposable in
            let disposeBag = Disposables.create()
            let url = URL(string: "\(request.baseURL)" + "\(request.path)")!
            Alamofire.request(url, method: request.method, parameters: request.parameters)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        observer(.success(data))
                    case .failure(let error):
                        observer(.error(error))
                    }
            }
            return disposeBag
        }
    }
}
