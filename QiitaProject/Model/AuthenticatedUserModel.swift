//
//  AuthenticatedUserModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

struct AuthenticatedUser {
    let itemsDescription, facebookID: String?
    let followeesCount, followersCount: Int?
    let githubLoginName, id: String?
    let itemsCount: Int?
    let linkedinID, location, name, organization: String?
    let permanentID: Int?
    let profileImageURL: String?
    let teamOnly: Bool?
    let twitterScreenName: String?
    let websiteURL: String?
    let imageMonthlyUploadLimit, imageMonthlyUploadRemaining: Int?
}
