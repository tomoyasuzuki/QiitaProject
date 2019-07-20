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
    
// - Property
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    var urlString: String =  ""
    var titleString: String = ""
    
// - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = titleString
        navigationItem.backBarButtonItem?.title = Resourses.string.backButtonTitle
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        webView.navigationDelegate = self
        
        navigateToItemPage(urlString: urlString)
    }
}

private extension ItemDetailViewController {
    
// - Navigation
    
    private func navigateToItemPage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
// - WebViewDelegate
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
