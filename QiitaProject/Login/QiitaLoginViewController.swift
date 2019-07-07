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
        
        // 1. 認証画面へ遷移
        toOauth()
        
        // アクセストークン取得
        viewModel.getAccessToken(authCode: authCode)
            .subscribe(onNext: { token in
              print("new token is \(token.token)")
            })
            .disposed(by: disoposeBag)
    }
    
    // パラメータの値を取得するメソッド
    func getParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })!.value! ?? ""
    }
}

// - function

private extension QiitaLoginViewController {
    // 画面遷移する
    // このViewControllerでユーザー情報を元にAPIを叩くか、次の画面に遷移した時にAPIを叩くか
}

// - webView

private extension QiitaLoginViewController {
    private func toOauth() {
        let urlRequest: URLRequest = viewModel.oauthURL
        print("urlrequest: \(urlRequest)")
        webView.load(urlRequest)
    }
    
    // OAuth画面から戻ってきた時の処理
    private func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        dismiss(animated: true, completion: nil)
        
        guard let url = navigationAction.request.url?.absoluteString else { return }
        // 認証コード取得
        guard let code = getParameter(url: url, param: "code") else { return }
        self.authCode = code   
    }
}
