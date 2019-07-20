//
//  HistoryViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        UITableView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Resourses.string.historyNavigationBarTitle
        navigationItem.backBarButtonItem?.title = ""
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // TODO: 閲覧した（詳細まで遷移した）記事をリアルタイムに反映させる。
        // HOW: データベースに記事を保存しておいてtableViewと結びつける
        // DO: itemDetailViewModelでアイテムをデータベースに保存する→HistoryViewModelでそれを取得してtableViewに表示する
        
        setupConstraints()
    }
}

extension HistoryViewController {
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.right.left.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

}
