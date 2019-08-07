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
    private lazy var webView: WKWebView = {
        WKWebView()
    }()
    
// - Property
    
    let viewModel = QiitaLoginViewModel()
    let disposeBag = DisposeBag()
    
// - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
        
        navigateToOauth()
        
        setupDataBinding()
    }
}

// - DataBinding

extension QiitaLoginViewController {
    private func setupDataBinding() {
        //TODO:  認証コードを取得するまでAPIを叩くのを待機させる
        viewModel.getAccessToken()
            .subscribe(onNext: { _ in
                print("call")
            })
            .disposed(by: disposeBag)
    }
}

extension QiitaLoginViewController {
    private func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

// - Delegate

extension QiitaLoginViewController {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        let url = webView.url?.absoluteString
        guard let code = getParameter(url: url!, param: "code") else { return }
        UserDefaults.standard.set(code, forKey: "authCode")
    }
}

// - Function

extension QiitaLoginViewController {
    private func navigateToOauth() {
        let request = OauthLoginRequest()
        let url = URL(string: request.baseURL + request.path)
        let urlRequest = URLRequest(url: (url?.queryItemAdded([URLQueryItem(name: Resourses.string.clientId, value: APIConstant.clientId), URLQueryItem(name: Resourses.string.clientSecret, value: APIConstant.clientSecret)]))!)
        webView.load(urlRequest)
    }
    
    private func getParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        // パラメータのnameがparamに初めて一致した時のvalueを取り出している
        return url.queryItems?.first(where: { $0.name == param })!.value! ?? ""
    }
}
