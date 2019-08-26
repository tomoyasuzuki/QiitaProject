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
    
    // - View
    
    private lazy var loginPromptView: UIView = {
        UIView()
    }()
    
    private lazy var loginPromptViewLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var loginPromptViewButton: UIButton = {
        UIButton()
    }()
    
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
        
        view.addSubview(loginPromptView)
        loginPromptView.addSubview(loginPromptViewLabel)
        loginPromptView.addSubview(loginPromptViewButton)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkUserStatus()
    }
    
    // - DataBinding
    
    private func setupDataBinding() {
        
        let output = viewModel.input()
        
        output
            .user
            .emit(onNext: { user in
                self.userNameLabel.text = user.name
                self.followeeCountLabel.text = user.followeesCount?.description
                self.followerCountLabel.text = user.followersCount?.description
                
                print(user)
                
                if let usreProfileImageUrlString: String = user.profileImageUrl {
                    Nuke.loadImage(with: URL(string: usreProfileImageUrlString)!, into: self.userProfileImageView)
                }
                
                UserDefaults.standard.set(user.id, forKey: "userId")
            })
            .disposed(by: disposeBag)
    }
    
    // - SetupLayout
    
    func setupLayout() {
        view.backgroundColor = UIColor.white
        
        loginPromptView.backgroundColor = UIColor.white
        loginPromptView.layer.cornerRadius = 4.0
        loginPromptView.layer.borderColor = UIColor.black.cgColor
        loginPromptView.layer.borderWidth = 2.0
        
        loginPromptViewLabel.text = "ログインすることでQiitaのプロフィールをアプリから閲覧することができます。"
        loginPromptViewLabel.numberOfLines = 0
        loginPromptViewLabel.lineBreakMode = .byCharWrapping
        
        loginPromptViewButton.setTitle("ログイン", for: .normal)
        loginPromptViewButton.layer.cornerRadius = 4.0
        loginPromptViewButton.backgroundColor = Resourses.color.qiitaColor
        loginPromptViewButton.setTitleColor(UIColor.gray, for: .normal)
        loginPromptViewButton.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 32.0, bottom: 8.0, right: 32.0)
        loginPromptViewButton.addTarget(self, action: #selector(navigateToLogin(_:)), for: .touchUpInside)
        
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
        
        followeeBackgroundView.backgroundColor = UIColor.gray
        followeeBackgroundView.layer.cornerRadius = 4.0
        followeeCountLabel.textAlignment = .center
        followeeCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        followeeTitleLabel.textAlignment = .center
        followeeTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        followerBackgroundView.backgroundColor = UIColor.gray
        followerBackgroundView.layer.cornerRadius = 4.0
        followerCountLabel.textAlignment = .center
        followerCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        followerTitleLabel.textAlignment = .center
        followerTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        stockItemsBackgroundView.backgroundColor = UIColor.gray
        stockItemsBackgroundView.layer.cornerRadius = 4.0
        stockItemsCountLabel.textAlignment = .center
        stockItemsCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        stockItemsTitleLabel.textAlignment = .center
        stockItemsTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        myTagsBackgroundView.backgroundColor = UIColor.gray
        myTagsBackgroundView.layer.cornerRadius = 4.0
        tagsCountLabel.textAlignment = .center
        tagsCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        tagsTitleLabel.textAlignment = .center
        tagsTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        tableViewHeaderView.backgroundColor = UIColor.gray
    }
    
    func setupDefaultValues() {
        loginPromptView.isHidden = true
        
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
        loginPromptView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
        
        loginPromptViewLabel.snp.makeConstraints { make in
            make.top.equalTo(loginPromptView.snp.top).offset(32)
            make.right.equalTo(loginPromptView).offset(-16)
            make.left.equalTo(loginPromptView).offset(16)
            make.centerX.equalTo(loginPromptView)
        }
        
        loginPromptViewButton.snp.makeConstraints { make in
            make.bottom.equalTo(loginPromptView.snp.bottom).offset(-20)
            make.centerX.equalTo(loginPromptView)
        }
        
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(120)
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


extension UserProfileViewController {
    func checkUserStatus() {
        if UserDefaults.standard.object(forKey: "SignIn") as? Bool == true {
            loginPromptView.isHidden = true
        } else {
           loginPromptView.isHidden = false
        }
    }
}

extension UserProfileViewController {
    @objc func navigateToLogin(_ sender: AnyObject) {
        navigationController?.pushViewController(QiitaLoginViewController(), animated: true)
    }
}

