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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = ItemsViewModel(searchBarObservable: searchBar.rx.text.orEmpty.asObservable())
    private let disposeBag = DisposeBag()
    
    var sideMenuNavigationController: UISideMenuNavigationController = UISideMenuNavigationController(rootViewController: SideMenuViewController())
    
    private let menuWidth: CGFloat = 200.0
    
    private var isLastCellRelay: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var isLastCellObservable: Observable<Bool> { return isLastCellRelay.asObservable() }
    
    // - View
    
    private lazy var menuButton: UIBarButtonItem = {
        UIBarButtonItem(image: Resourses.image.menuButton, style: .plain, target: self, action: #selector(openSideMenu(_:)))
    }()
    
    // - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = menuButton
        
        navigationItem.title = Resourses.string.searchNavigationBarTitle
        
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
            //TODO: LastCellをViewModelに通知する
        }
    }
    
    // - DataBinding
    
    private func setupDataBinding() {
        
        viewModel.itemsObservable
            .drive(onNext: { _ in self.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        viewModel.fetchItems()
            .subscribe(onNext: { _ in
                print("text")
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoadingObservable
            .drive(onNext: { isLoading in
                if isLoading {} else {}
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
