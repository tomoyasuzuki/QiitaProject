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
    
// - Property
    
    let viewModel = QiitaLoginViewModel()
    let disposeBag = DisposeBag()
    var accesToken: String = ""
    var authCode: String = ""
    
// - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        navigateToOauth()
        
        setupDataBinding()
    }
}

// - DataBinding

extension QiitaLoginViewController {
    private func setupDataBinding() {
    
    }
}

// - Delegate

extension QiitaLoginViewController {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString {
            guard let code = getParameter(url: url, param: "code") else { return }
            self.authCode = code
            print("get code")
            
            // アクセストークン取得
            viewModel.getAccessToken(authCode: authCode)
                .subscribe(onNext: { token in
                    self.accesToken = token.token
                    print("get accesstoken")
                })
                .disposed(by: disposeBag)
            
            performSegue(withIdentifier: Resourses.string.toUserProfile, sender: (accesToken))
        } else {
            
        }
    }
}

// - Function

extension QiitaLoginViewController {
    private func navigateToOauth() {
        let request = OauthLoginRequest()
        let url = URL(string: request.baseURL + request.path)
        let urlRequest = URLRequest(url: (url?.queryItemAdded([URLQueryItem(name: Resourses.string.clientId, value: API.clientId), URLQueryItem(name: Resourses.string.clientSecret, value: API.clientSecret)]))!)
        webView.load(urlRequest)
    }
    
    private func getParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        // パラメータのnameがparamに初めて一致した時のvalueを取り出している
        return url.queryItems?.first(where: { $0.name == param })!.value! ?? ""
    }
}

// - Segue

extension QiitaLoginViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Resourses.string.toUserProfile {
            let vc = segue.destination as! UserProfileViewController
            vc.accessToken = sender as! String
        }
    }
}
