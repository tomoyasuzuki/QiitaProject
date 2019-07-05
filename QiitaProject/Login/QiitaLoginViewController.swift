//
//  QiitaLoginViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import WebKit

class QiitaLoginViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        // 認証画面へ遷移
        toOauth()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 認証が終わった後の処理
        // apiを叩いてユーザーの詳細情報を取得する
    }
}

private extension QiitaLoginViewController {
    private func toOauth() {
        let url: URL = URL(string: api.baseUrl + API.Path.oauth.rawValue)!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
