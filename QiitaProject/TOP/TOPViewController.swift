//
//  TOPViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/09.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class TopViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: Resourses.string.toWebView, sender: nil)
    }
}
