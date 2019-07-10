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
    let disposeBag = DisposeBag()
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

extension QiitaLoginViewController {
    private func setupDataBinding() {
        // アクセストークン取得
        viewModel.getAccessToken(authCode: authCode)
            .subscribe(onNext: { token in
                self.accesToken = token.token
            })
            .disposed(by: disposeBag)
    }
}

// - webViewDelegate

extension QiitaLoginViewController {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString {
            // 認証コード取得
            guard let code = getParameter(url: url, param: "code") else { return }
            self.authCode = code
            // webViewを閉じる
            //            dismiss(animated: true, completion: nil)
            print(url)
            print("code取得：\(authCode)")
            
            // 画面遷移
            performSegue(withIdentifier: "toUserProfile", sender: (accesToken))
        } else {
            // 例外処理？
        }
    }
}

// - function

extension QiitaLoginViewController {
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

// - segue

extension QiitaLoginViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserProfile" {
            let vc = segue.destination as! UserProfileViewController
            vc.accessToken = sender as! String
        }
    }
}
