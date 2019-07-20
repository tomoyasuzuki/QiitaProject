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
    
    private let viewModel = UserProfileViewModel()
    private let disposeBag = DisposeBag()
    
    private let backgroundViewSize: CGSize = CGSize(width: 60.0, height: 60.0)
    
    var itemsCount: Int = 0
    
    // - View
    
    private lazy var userProfileImageView: UIImageView = {
        UIImageView()
    }()
    private lazy var userNameLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var border: UIView = {
        UIView()
    }()
    
    
    private lazy var userContentsArea: UIStackView = {
        UIStackView()
    }()
    
    private lazy var followeeBackgroundView: UIView = {
        UIView()
    }()
    
    private lazy var followerBackgroundView: UIView = {
        UIView()
    }()
    
    private lazy var stockItemsBackgroundView: UIView = {
        UIView()
    }()
    
    private lazy var myTagsBackgroundView: UIView = {
        UIView()
    }()
    
    private lazy var followeeCountLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var followeeTitleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var followerCountLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var followerTitleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var stockItemsCountLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var stockItemsTitleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var tagsCountLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var tagsTitleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var tableViewHeaderView: UIView = {
        UIView()
    }()
    
    // - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.title = "プロフィール"
        
        view.addSubview(userProfileImageView)
        view.addSubview(userNameLabel)
        view.addSubview(border)
        view.addSubview(userContentsArea)
        view.addSubview(tableViewHeaderView)
        
        userContentsArea.addArrangedSubview(followeeBackgroundView)
        userContentsArea.addArrangedSubview(followerBackgroundView)
        userContentsArea.addArrangedSubview(stockItemsBackgroundView)
        userContentsArea.addArrangedSubview(myTagsBackgroundView)
        
        followeeBackgroundView.addSubview(followeeTitleLabel)
        followeeBackgroundView.addSubview(followeeCountLabel)
        
        followerBackgroundView.addSubview(followerCountLabel)
        followerBackgroundView.addSubview(followerTitleLabel)
        
        stockItemsBackgroundView.addSubview(stockItemsCountLabel)
        stockItemsBackgroundView.addSubview(stockItemsTitleLabel)
        
        myTagsBackgroundView.addSubview(tagsCountLabel)
        myTagsBackgroundView.addSubview(tagsTitleLabel)

        setupDataBinding()
        setupLayout()
        setupDefaultValues()
        setupConstraints()
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
        
        userNameLabel.textColor = UIColor.white
        
        userContentsArea.axis = .horizontal
        userContentsArea.alignment = .fill
        userContentsArea.distribution = .fillEqually
        userContentsArea.spacing = 16
        
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
        followerTitleLabel.text = "フォロー"
        
        followerCountLabel.text = "0"
        followerTitleLabel.text = "フォロワー"
        
        stockItemsCountLabel.text = "0"
        stockItemsTitleLabel.text = "件"
        
        tagsCountLabel.text = "0"
        tagsTitleLabel.text = "件"
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
        
        userContentsArea.snp.makeConstraints { make in
            make.height.equalTo(followeeBackgroundView)
            make.top.equalTo(border.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.left.equalTo(view).offset(16)
        }
        
        followeeBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(backgroundViewSize)
        }
        
        followerBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(backgroundViewSize)
        }
        
        stockItemsBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(backgroundViewSize)
        }
        
        myTagsBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(backgroundViewSize)
        }
        
        followeeCountLabel.snp.makeConstraints { make in
            make.center.equalTo(followeeBackgroundView)
        }
        
        followerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(followeeCountLabel.snp.bottom).offset(4)
            make.centerX.equalTo(followeeCountLabel)
        }
        
        followerCountLabel.snp.makeConstraints { make in
            make.center.equalTo(followeeBackgroundView)
        }
        
        followerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(followerCountLabel.snp.bottom).offset(4)
            make.centerX.equalTo(followerCountLabel)
        }
        
        stockItemsCountLabel.snp.makeConstraints { make in
            make.center.equalTo(stockItemsBackgroundView)
        }
        
        stockItemsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stockItemsCountLabel.snp.bottom).offset(4)
            make.centerX.equalTo(stockItemsCountLabel)
        }
        
        tagsCountLabel.snp.makeConstraints { make in
            make.center.equalTo(myTagsBackgroundView)
        }
        
        tagsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(tagsCountLabel.snp.bottom).offset(4)
            make.centerX.equalTo(tagsCountLabel)
        }
        
        tableViewHeaderView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(userContentsArea.snp.bottom).offset(16)
            make.right.left.equalTo(view)
        }
    }
}

