//
//  UserModel.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/06/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import Foundation

struct ItemUser: Codable {
    let userDescription, facebookID: String?
    let followeesCount, followersCount: Int?
    let githubLoginName, id: String?
    let itemsCount: Int?
    let linkedinID, location, name, organization: String?
    let permanentID: Int?
    let profileImageUrl: String?
    let teamOnly: Bool?
    let twitterScreenName: String?
    let websiteURL: String?
    
    enum CodingKeys: String, CodingKey {
        case userDescription
        case facebookID = "facebook_id"
        case followeesCount
        case followersCount
        case githubLoginName = "github_login_name"
        case id
        case itemsCount
        case linkedinID = "linkedin_id"
        case location
        case name
        case organization
        case permanentID = "permanent_id"
        case profileImageUrl = "profile_image_url"
        case teamOnly
        case twitterScreenName = "twitter_screen_name"
        case websiteURL = "website_url"
    }
}

