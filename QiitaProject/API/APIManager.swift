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
    let baseUrl: String = "https://qiita.com/api/v2"
    
    // リクエストメソッド
    func call(path: String, method: HTTPMethod = .get, parameters: Parameters = [:]) -> Single<Data> {
        return Single.create { (observer) -> Disposable in
            let disposeBag = Disposables.create()
            let url = URL(string: "\(self.baseUrl)" + "\(path)")!
            Alamofire.request(url, method: method, parameters: parameters)
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

// path
extension API {
    enum Path: String {
        case items = "/items"
        case users = "/users"
        case tags = "/tags"
        case oauth = "/oauth/authorize"
    }
}

// parameters
extension API {
    enum QiitaParameters {
        case items(query: String)
        case login
        
        var params: Parameters {
            switch self {
            case .items(let query):
                return ["query": query]
            case .login:
                return ["client_id": "956b371103c3679441aee2b897bdf94eb6d28be8", "scope": "read_qiita" + "write_qiita"]
                
            }
        }
    }
}
