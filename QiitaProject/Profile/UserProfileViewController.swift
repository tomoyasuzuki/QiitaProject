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
    
    private let backgroundViewSize: CGSize = CGSize(width: 75.0, height: 75.0)
    
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
      
        navigationItem.title = Resourses.string.userProfileNavigationBarTitle
        
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
        view.backgroundColor = UIColor.white
        
        userProfileImageView.layer.cornerRadius = 4.0
        userProfileImageView.alpha = 0.5
        userProfileImageView.backgroundColor = UIColor.gray
        
        userNameLabel.textColor = UIColor.gray
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        userNameLabel.numberOfLines = 2
        userNameLabel.lineBreakMode = .byCharWrapping
        
        userContentsArea.axis = .horizontal
        userContentsArea.alignment = .fill
        userContentsArea.distribution = .fillEqually
        userContentsArea.spacing = 16
        
        followeeBackgroundView.backgroundColor = Resourses.color.qiitaColor
        followeeBackgroundView.layer.cornerRadius = 4.0
        followeeCountLabel.textAlignment = .center
        followeeCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        followeeTitleLabel.textAlignment = .center
        followeeTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        followerBackgroundView.backgroundColor = Resourses.color.qiitaColor
        followerBackgroundView.layer.cornerRadius = 4.0
        followerCountLabel.textAlignment = .center
        followerCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        followerTitleLabel.textAlignment = .center
        followerTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        stockItemsBackgroundView.backgroundColor = Resourses.color.qiitaColor
        stockItemsBackgroundView.layer.cornerRadius = 4.0
        stockItemsCountLabel.textAlignment = .center
        stockItemsCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        stockItemsTitleLabel.textAlignment = .center
        stockItemsTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        myTagsBackgroundView.backgroundColor = Resourses.color.qiitaColor
        myTagsBackgroundView.layer.cornerRadius = 4.0
        tagsCountLabel.textAlignment = .center
        tagsCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        tagsTitleLabel.textAlignment = .center
        tagsTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        tableViewHeaderView.backgroundColor = Resourses.color.qiitaColor
    }
    
    func setupDefaultValues() {
        userNameLabel.text = Resourses.string.userNameDefault
        followeeCountLabel.text = "0"
        followeeTitleLabel.text = Resourses.string.unitFolloweeCount
        
        followerCountLabel.text = "0"
        followerTitleLabel.text = Resourses.string.unitFollowerCount
        
        stockItemsCountLabel.text = "0"
        stockItemsTitleLabel.text = Resourses.string.unitItemCount
        
        tagsCountLabel.text = "0"
        tagsTitleLabel.text = Resourses.string.unitItemCount
    }
    
    
    // - Constraints
    func setupConstraints() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(32)
            make.size.equalTo(backgroundViewSize)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView)
            make.left.equalTo(userProfileImageView.snp.right).offset(16)
            make.right.lessThanOrEqualTo(view).offset(-32)
        }
        
        border.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.top.equalTo(userProfileImageView.snp.bottom).offset(16)
            make.right.left.equalTo(view)
        }
        
        userContentsArea.snp.makeConstraints { make in
            make.height.equalTo(followeeBackgroundView)
            make.top.equalTo(border.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-32)
            make.left.equalTo(view).offset(32)
        }
        
        // backgroundview
        
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
        
        // labels
        
        followeeCountLabel.snp.makeConstraints { make in
            make.center.equalTo(followeeBackgroundView)
        }
        
        followeeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(followeeCountLabel.snp.bottom).offset(4)
            make.centerX.equalTo(followeeCountLabel)
        }
        
        followerCountLabel.snp.makeConstraints { make in
            make.center.equalTo(followerBackgroundView)
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

