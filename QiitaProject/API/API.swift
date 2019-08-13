//
//  API.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/06/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import Alamofire

class API {
    func call<T: RequestProtocol>(_ request: T) -> Single<DataResponse<Data>> {
        return Single.create { (observer) -> Disposable in
            let disposeBag = Disposables.create()
            guard let url = URL(string: "\(request.baseURL)\(request.path)") else {
                observer(.error(APIError.invalidUrl))
                return disposeBag
            }
            
            Alamofire.request(url, method: request.method, parameters: request.parameters,encoding: request.encoding)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success:
                        observer(.success(response))
                    case .failure(let error):
                        print("failure:\(error.localizedDescription)")
                        observer(.error(error))
                }
            }
            return disposeBag
        }
    }
}
