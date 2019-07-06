//
//  QiitaLoginViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/02.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class QiitaLoginViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    
    let api = API()
    let viewModel = QiitaLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        // 認証画面へ遷移
        toOauth()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        dismiss(animated: true, completion: nil)
        
        guard let url = navigationAction.request.url?.absoluteString else { return }
        // 認証コード取得
        let authCode = getParameter(url: url, param: "code")
        // アクセストークン取得
        viewModel.getAccessToken(authCode: authCode!)
        
    }
    
    func getParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })!.value! ?? ""
    }
}

private extension QiitaLoginViewController {
    private func toOauth() {
        guard let url: URL = URL(string: api.baseUrl + API.Path.oauth.rawValue) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
