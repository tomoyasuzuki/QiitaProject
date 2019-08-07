//
//  HistoryViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase

class HistoryViewController: UIViewController {
    
    private var viewModel = HisotryViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        UITableView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Resourses.string.historyNavigationBarTitle
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(itemTableViewCell.self, forCellReuseIdentifier: "HisotoryCell")

        // TODO: 閲覧した（詳細まで遷移した）記事をリアルタイムに反映させる。
        // HOW: データベースに記事を保存しておいてtableViewと結びつける
        // DO: itemDetailViewModelでアイテムをデータベースに保存する→HistoryViewModelでそれを取得してtableViewに表示する
        
        setupConstraints()
    }
}

extension HistoryViewController {
    func setupDataBindimg() {
        
        viewModel.getHistory()
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
        return self.viewModel.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HisotoryCell", for: indexPath) as! itemTableViewCell
        cell.bind(items: viewModel.history, indexPath: indexPath)
        return cell
    }

}
