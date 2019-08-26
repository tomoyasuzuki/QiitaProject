//
//  AuthenticatedUserModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

struct AuthenticatedUser: Codable {
    let itemsDescription, facebookId: String?
    let followeesCount, followersCount: Int?
    let githubLoginName, id: String?
    let itemsCount: Int?
    let linkedinId, location, name, organization: String?
    let permanentId: Int?
    let profileImageUrl: String?
    let teamOnly: Bool?
    let twitterScreenName: String?
    let websiteUrl: String?
    let imageMonthlyUploadLimit, imageMonthlyUploadRemaining: Int?
}
