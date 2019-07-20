//
//  Resouses.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/10.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import UIKit

struct Resourses {
    internal struct string {
        // URL
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        
        // button
        static let backButtonTitle = "戻る"
        static let loginButtonTitle = "ログイン"
        static let historyButtonTitle = "閲覧履歴"
        // segue
        static let toWebView = "toWebView"
        static let toUserProfile = "toUserProfile"
        static let toItemDetail = "toItemDetail"
        // cell
        static let itemTableViewCell = "itemTableViewCell"
        static let userStockItemTableViewCell = "userStockItemTableViewCell"
        // title
        static let backBarButtonTitle = "戻る"
        static let tagTitle = "タグ"
        static let tagEmptyDescription = "タグがありません"
        static let searchNavigationBarTitle = "Qiita記事を検索"
        // Profile
        static let userProfileNavigationBarTitle = "Qiitaプロフィール"
        static let userNameDefault = "ログインするとユーザー名が表示されます"
        // History
        static let historyNavigationBarTitle = "閲覧履歴"
        // Unit
        static let unitFolloweeCount = "フォロー"
        static let unitFollowerCount = "フォロワー"
        static let unitPersonCount = "人"
        static let unitItemCount = "件"
    }
    
    internal struct image {
        static let gear = UIImage(named: "gear")
        static let menuButton = UIImage(named: "MenuButton")
    }
    
    internal struct color {
        static let qiitaColor = UIColor.hex(string: "00FF00", alpha: 0.50)
    }
}
