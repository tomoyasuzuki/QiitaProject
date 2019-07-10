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
        static let baseURL = "https://qiita.com/api/v2"
        static let redirectURL = "https://www.tomonariSuzukiredirect.com"
        static let clientId = "956b371103c3679441aee2b897bdf94eb6d28be8"
        static let clientSecret = "3f3fc429c399fbed68340b6a5d1c75d2ed877ac9"
        
        // button
        static let backButtonTitle = "戻る"
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
        // subTitle
    }
    
    internal struct image {
        static let gear: UIImage = UIImage(named: "gear")!
    }
}
