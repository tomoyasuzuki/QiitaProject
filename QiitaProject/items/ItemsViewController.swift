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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = ItemsViewModel()
    private let disposeBag = DisposeBag()
    fileprivate let refresh = UIRefreshControl()
    
    private var isLoading = false
    private let defaultNumberOfRows = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshTableView(_ :)), for: .valueChanged)
        
        tableView.isHidden = true
        
        tableView.register(itemTableViewCell.self, forCellReuseIdentifier: "itemTableViewCell")
        
        viewModel.fetchItems(observable: searchBar.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { _ in
                self.isLoading = false
                self.tableView.isHidden = false
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    
    // - Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isLoading {
            return defaultNumberOfRows
        } else {
            return viewModel.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! itemTableViewCell
        cell.bind(items: viewModel.items, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 200
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルを特定
        let item = viewModel.items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let title = item.title, let url = item.url else { return }

        // 画面遷移
        performSegue(withIdentifier: "toItemDetail", sender: (title, url))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 最下部のセルを検知
        let lastCellRow = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastCellRow {
            
        }
    }
    
    // - function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemDetail" {
            let vc = segue.destination as! ItemDetailViewController
            (vc.titleString, vc.urlString) = sender as! (String, String)
        }
    }
    
    @objc func refreshTableView(_ sender: AnyObject) {
        // APIを叩く
        // itemsのcountが増える
        // reloadtableした時にセルが増える
    }
}

