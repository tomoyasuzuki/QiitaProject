//
//  TOPViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/09.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class TOPViewController: ViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var itemsTabButton: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "toWebView", sender: nil)
    }
    
}
