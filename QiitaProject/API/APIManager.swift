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
    static let baseUrl: String = "https://qiita.com/api/v2"
    static let clientId: String = "956b371103c3679441aee2b897bdf94eb6d28be8"
    static let clientSecret: String = ""
    
    var oauthURL: URLRequest {
        let url: URL = URL(string: API.baseUrl + API.Path.oauth.rawValue)!
        let urlRequest = URLRequest(url: url.queryItemAdded([URLQueryItem(name: API.Key.clientId.rawValue, value: API.clientId), URLQueryItem(name: API.Key.clientSecret.rawValue, value: API.clientSecret)])!)
        return urlRequest
    }
    
    // リクエストメソッド
    func call(path: String, method: HTTPMethod = .get, parameters: Parameters = [:]) -> Single<Data> {
        return Single.create { (observer) -> Disposable in
            let disposeBag = Disposables.create()
            let url = URL(string: "\(API.baseUrl)" + "\(path)")!
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
        case acceessToken = "/access_tokens"
    }
}

// parameters

extension API {
    enum QiitaParameters {
        case query(query: String, perPage: Int)
        case oauth
        case getToken(code: String)
        case page(page: Int)
        
        
        var params: Parameters {
            switch self {
            case .query(let query, let perPage):
                return ["query": query, "per_page": "\(perPage)"]
            case .oauth:
                return ["client_id": "956b371103c3679441aee2b897bdf94eb6d28be8",
                        "scope": "read_qiita"]
            case .getToken(let code):
                return ["client_id": "956b371103c3679441aee2b897bdf94eb6d28be8",
                        "client_secret": "3f3fc429c399fbed68340b6a5d1c75d2ed877ac9",
                        "code": code]
            case .page(let page):
                return ["page": "\(page)"]
                
            }
        }
    }
    
    enum Key: String {
        case query = "query"
        case page = "page"
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
}
