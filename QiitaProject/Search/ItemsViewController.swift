//
//  ViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/06/30.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Nuke
import RxCocoa
import RxSwift
import UIKit
import SideMenu

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // - Property
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private let viewModel = ItemsViewModel()
    private let disposeBag = DisposeBag()
    
    internal var serarchBarObservable: Observable<String> {
        return searchBar.rx.text.orEmpty
            .asObservable()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { $0.count >= 2 }
    }
    
    var sideMenuNavigationController: UISideMenuNavigationController = UISideMenuNavigationController(rootViewController: SideMenuViewController())
    
    private var isLastCell: Bool = false
    private let menuWidth: CGFloat = 200.0
    
    // - View
    
    private lazy var menuButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(named: "MenuButton"), style: .plain, target: self, action: #selector(openSideMenu(_:)))
    }()
    
    // - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = menuButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(itemTableViewCell.self, forCellReuseIdentifier: Resourses.string.itemTableViewCell)
        
        setupDataBinding()
        setupSideMenu()
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
            isLastCell = true
        } else {
            isLastCell = false
        }
    }
    
    // - DataBinding
    
    private func setupDataBinding() {
        // items
        viewModel.itemsObservable
            .drive(onNext: { _ in self.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        // fetch
        
        viewModel.fetchItems(observable: serarchBarObservable)
            .subscribe(onNext: { _ in
                // What to do
            })
            .disposed(by: disposeBag)
        
        // loading
        
        viewModel.isLoadingObservable
            .drive(onNext: { isLoading in
                if isLoading {} else {}
            })
            .disposed(by: disposeBag)
        
        // refetch
        
        viewModel.fetchMoreItems(isLastCellObservable: Observable.of(isLastCell), observable: searchBar.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { _ in
                // What to do
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = sideMenuNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: navigationController!.view)
        SideMenuManager.default.menuWidth = menuWidth
        SideMenuManager.default.menuPresentMode = .menuSlideIn
    }
    
    @objc private func openSideMenu(_ sender: AnyObject) {
        present(sideMenuNavigationController, animated: true, completion: nil)
    }
}
