//
//  ItemDetailViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/03.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import WebKit

class ItemDetailViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    var urlString: String =  ""
    var titleString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        webView.navigationDelegate = self
        print(webView)
        
        toItemPage(urlString: urlString)
    }
}

private extension ItemDetailViewController {
    private func toItemPage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("リクエスト前")
        
        /*  これを設定しないとアプリがクラッシュする
         *  .allow  : 読み込み許可
         *  .cancel : 読み込みキャンセル
         */
        decisionHandler(.allow)
    }
}
