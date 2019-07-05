//
//  ViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/06/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let viewModel = ItemsViewModel()
    private var items: [Item] = []
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(itemTableViewCell.self, forCellReuseIdentifier: "itemTableViewCell")
        
        viewModel.fetchItems(observable: searchBar.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { (item) in
                self.items = item
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
    }
    
    // - Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! itemTableViewCell
        cell.bind(items: self.items, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 200
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルを特定
        let item = self.items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let title = item.title, let url = item.url else { return }
        let itemDetailViewController = ItemDetailViewController(title: title, url: url)

        // 画面遷移
        self.navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

