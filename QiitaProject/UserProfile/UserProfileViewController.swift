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

class UserProfileViewController: UIViewController {
    
   // - Property
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var followeeBackgroundView: UIView!
    @IBOutlet weak var followerBackgroundView: UIView!
    @IBOutlet weak var stockItemsBackgroundView: UIView!
    @IBOutlet weak var myTagsBackgroundView: UIView!
    @IBOutlet weak var followeeCountLabel: UILabel!
    @IBOutlet weak var followeeTitleLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followerTitleLabel: UILabel!
    @IBOutlet weak var stockItemsCountLabel: UILabel!
    @IBOutlet weak var stockItemsTitleLabel: UILabel!
    @IBOutlet weak var tagsCountLabel: UILabel!
    @IBOutlet weak var tagsTitleLabel: UILabel!
    @IBOutlet weak var tableViewHeaderView: UIView!
    
    private let viewModel = UserProfileViewModel()
    private let disposeBag = DisposeBag()

    private let backgroundViewSize: CGSize = CGSize(width: 60.0, height: 60.0)
    
    var itemsCount: Int = 0
    
    private lazy var menuButton: UIBarButtonItem = {
        UIBarButtonItem()
    }()
    
    // - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = menuButton

        setupDataBinding()
        setupLayout()
        setupDefaultValues()
    }
    
    // - DataBinding
    
    private func setupDataBinding() {
        viewModel.fetchUserProfile()?
            .subscribe(onNext: { userProfile in
                self.userNameLabel.text = userProfile.name
                self.followeeCountLabel.text = userProfile.followeesCount?.description
                self.followerCountLabel.text = userProfile.followersCount?.description
                
                guard let usreProfileImageUrlString: String = userProfile.profileImageUrl else { return }
                Nuke.loadImage(with: URL(string: usreProfileImageUrlString)!, into: self.userProfileImageView)
                
                guard let itemsCount = userProfile.itemsCount else { return }
                self.itemsCount = itemsCount
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchUserFolloingTags()?
            .subscribe(onNext: { tags in
                self.tagsCountLabel.text = tags.count.description
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchUserStockItems()?
            .subscribe(onNext: { stockItems in
                self.stockItemsCountLabel.text = stockItems.count.description
            })
            .disposed(by: disposeBag)
    }
    
    // - SetupLayout
    
    func setupLayout() {
        
        userProfileImageView.layer.cornerRadius = 4.0
        userProfileImageView.alpha = 0.5
        
        followeeBackgroundView.backgroundColor = Resourses.color.qiitaColor
        followeeBackgroundView.layer.cornerRadius = 4.0
        followeeCountLabel.textAlignment = .center
        followeeTitleLabel.textAlignment = .center
        
        followerBackgroundView.backgroundColor = Resourses.color.qiitaColor
        followerBackgroundView.layer.cornerRadius = 4.0
        followerCountLabel.textAlignment = .center
        followerTitleLabel.textAlignment = .center
        
        stockItemsBackgroundView.backgroundColor = Resourses.color.qiitaColor
        stockItemsBackgroundView.layer.cornerRadius = 4.0
        stockItemsCountLabel.textAlignment = .center
        stockItemsTitleLabel.textAlignment = .center
        
        myTagsBackgroundView.backgroundColor = Resourses.color.qiitaColor
        myTagsBackgroundView.layer.cornerRadius = 4.0
        tagsCountLabel.textAlignment = .center
        tagsTitleLabel.textAlignment = .center
        
        tableViewHeaderView.backgroundColor = Resourses.color.qiitaColor
    }
    
    func setupDefaultValues() {
        userProfileImageView.backgroundColor = UIColor.gray
        userNameLabel.text = "ログインすると名前が表示されます"
        followeeCountLabel.text = "0"
        followerCountLabel.text = "0"
        stockItemsCountLabel.text = "0"
        tagsCountLabel.text = "0"
    }
    
    
    // - Constraints
    func setupConstraints() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.left.equalTo(view).offset(32)
            make.size.equalTo(backgroundViewSize)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView)
            make.left.equalTo(userProfileImageView.snp.right).offset(16)
        }
        
        border.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.top.equalTo(userProfileImageView.snp.bottom).offset(16)
            make.right.left.equalTo(view)
        }
    }
}

