//
//  ResponseProtocol.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/13.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import Alamofire

protocol ResponseProtocol {
    associatedtype Element
    var responseItems: [Element] { get }
    var httpHeaders: HTTPHeaders { get }
}
