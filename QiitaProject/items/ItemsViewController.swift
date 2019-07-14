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
    
    // - Property
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = ItemsViewModel()
    private let disposeBag = DisposeBag()
    fileprivate let refresh = UIRefreshControl()
    
    private let defaultNumberOfRows = 10
    private var isLastCell: Bool = false
    
    private var enableFetchMoreItems: Bool = false
    
    // - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(itemTableViewCell.self, forCellReuseIdentifier: Resourses.string.itemTableViewCell)
        
        setupDataBinding()
    }
    
    // - Override
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Resourses.string.toItemDetail {
            let vc = segue.destination as! ItemDetailViewController
            (vc.titleString, vc.urlString) = sender as! (String, String)
        }
    }
    
    // - Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resourses.string.itemTableViewCell, for: indexPath) as! itemTableViewCell
        cell.bind(items: viewModel.items, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 200
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let title = item.title, let url = item.url else { return }
        
        performSegue(withIdentifier: Resourses.string.toItemDetail, sender: (title, url))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCellRow = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastCellRow {
            self.isLastCell = true
        } else {
            self.isLastCell = false
        }
    }
    
    // - DataBinding
    
    private func setupDataBinding() {
        
        // fetch items
        
        viewModel.fetchItems(observable: searchBar.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
                print("fetch items")
            })
            .disposed(by: disposeBag)
        
        // loading
        
        viewModel.isLoadingObservable
            .subscribe(onNext: { isLoading in
                if isLoading {
                   print("loading")
                } else {
                   print("loading")
                }
            })
            .disposed(by: disposeBag)
        
        // more items
        
        viewModel.fetchMoreItems(isLastCellObservable: Observable.of(self.isLastCell), observable: searchBar.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
                print("more items")
            })
            .disposed(by: disposeBag)
    }
}

