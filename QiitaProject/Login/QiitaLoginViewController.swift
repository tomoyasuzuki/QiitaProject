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
import RxCocoa

class QiitaLoginViewController: UIViewController, WKNavigationDelegate {
    private lazy var webView: WKWebView = {
        WKWebView()
    }()
    
// - Property
    
    let viewModel = QiitaLoginViewModel()
    let disposeBag = DisposeBag()
    
    let relay: PublishRelay<String> = PublishRelay<String>()
    
// - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
        
        setupDataBinding()
        navigateToOauth()
    }
}

// - DataBinding

extension QiitaLoginViewController {
    private func setupDataBinding() {
        let outlet = viewModel.input(authCode: relay)
        
        outlet
            .transition
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.navigateToUserProfile()
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
        relay.accept(code)
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
        print("debug url: \(url)")
        // パラメータのnameがparamに初めて一致した時のvalueを取り出している
        return url.queryItems?.first(where: { $0.name == param })!.value! ?? ""
    }
}

extension QiitaLoginViewController {
    private func navigateToUserProfile() {
        navigationController?.pushViewController(UserProfileViewController(), animated: true)
    }
}


