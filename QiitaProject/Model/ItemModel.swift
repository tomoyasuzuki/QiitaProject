//
//  ItemModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/06/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let items = try Items(json)

struct Item: Codable {
    let renderedBody, body: String?
    let coediting: Bool?
    let commentsCount: Int?
    let createdAt: String?
    let group: Group?
    let id: String?
    let likesCount: Int?
    let itemPrivate: Bool?
    let reactionsCount: Int?
    let tags: [Tag]?
    let title: String?
    let updatedAt: String?
    let url: String?
    let user: User?
    let pageViewsCount: Int?
}
