//
//  UserProfileViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/07.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var followeeBackgroundView: UIView!
    @IBOutlet weak var followerBackgroundView: UIView!
    @IBOutlet weak var stockItemsBackgroundView: UIView!
    @IBOutlet weak var myTagsBackgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var followeeCountLabel: UILabel!
    @IBOutlet weak var followeeTitleLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followerTitleLabel: UILabel!
    @IBOutlet weak var stockItemsCountLabel: UILabel!
    @IBOutlet weak var stockItemsTitleLabel: UILabel!
    @IBOutlet weak var tagsCountLabel: UILabel!
    @IBOutlet weak var tagsTitleLabel: UILabel!
    
    private let viewModel = UserProfileViewModel()
    private let disposeBag = DisposeBag()
    
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupDataBinding()
    }
    
    private func setupDataBinding() {
        viewModel.fetchUserProfile(userId: userId)
            .subscribe(onNext: { userProfile in
                guard let usreProfileImageUrlString: String = userProfile.profileImageUrl else { return }
                Nuke.loadImage(with: URL(string: usreProfileImageUrlString)!, into: self.userProfileImageView)
                
                self.userNameLabel.text = userProfile.name
                self.followeeCountLabel.text = userProfile.followeesCount?.description
                self.followerCountLabel.text = userProfile.followersCount?.description
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchUserFolloingTags(userId: userId)
            .subscribe(onNext: { tags in
                self.tagsCountLabel.text = tags.count.description
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchUserStockItems(userId: userId)
            .subscribe(onNext: { stockItems in
                self.stockItemsCountLabel.text = stockItems.count.description
            })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        return cell
    }
}
