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
import RxSwift

class QiitaLoginViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    
    let viewModel = QiitaLoginViewModel()
    let disoposeBag = DisposeBag()
    var accesToken: String = ""
    var authCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        toOauth()
        
        setupDataBinding()
    }
}

// - dataBinding

private extension QiitaLoginViewController {
    private func setupDataBinding() {
        // dataBinding
    }
}

// - webViewDelegate

private extension QiitaLoginViewController {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if webView.url?.absoluteString == API.redirectURL {
            // この処理は結局いつ呼ばれるのかどうか？
            dismiss(animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if  let url = navigationAction.request.url?.absoluteString {
            if url == API.redirectURL {
                // リダイレクトをキャンセル
                decisionHandler(WKNavigationActionPolicy.cancel)
                // 認証コード取得
                guard let code = getParameter(url: url, param: "code") else { return }
                self.authCode = code
                // アクセストークン取得
                viewModel.getAccessToken(authCode: authCode)
                    
                // webViewを閉じる
                dismiss(animated: true, completion: nil)
            }
        } else {
            print("unexpected redirect url")
        }
    }
}

// - function

private extension QiitaLoginViewController {
    private func toOauth() {
        let request = OauthLoginRequest()
        let url = URL(string: request.baseURL + request.path)
        let urlRequest = URLRequest(url: (url?.queryItemAdded([URLQueryItem(name: "client_id", value: API.clientId), URLQueryItem(name: "client_secret", value: API.clientSecret)]))!)
        webView.load(urlRequest)
    }
    
    private func getParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        // パラメータのnameがparamに初めて一致した時のvalueを取り出している
        return url.queryItems?.first(where: { $0.name == param })!.value! ?? ""
    }
}
