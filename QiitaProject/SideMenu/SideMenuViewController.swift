//
//  SideMenuViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    // MARK: Property
    
    private let buttonHeight: CGFloat = 30.0
    private let iconImageViewHeight: CGFloat = 36.0
    
    // MARK: View
    
    private lazy var userProfileImageButton: UIButton = {
        UIButton()
    }()
    
    private lazy var userProfileImageButtonBorderButtom: UIView = {
        UIView()
    }()

    private lazy var historyImageButton: UIButton = {
        UIButton()
    }()
    
    private lazy var historyImageButtonBorderButtom: UIView = {
        UIView()
    }()
    
    private lazy var inquiryImageButton: UIButton = {
        UIButton()
    }()
    
    private lazy var inquiryImageButtonBorderButtom: UIView = {
        UIView()
    }()
    
    private lazy var appInfoImageButton: UIButton = {
        UIButton()
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(userProfileImageButton)
        view.addSubview(userProfileImageButtonBorderButtom)
        view.addSubview(historyImageButton )
        view.addSubview(historyImageButtonBorderButtom)
        view.addSubview(inquiryImageButton)
        view.addSubview(inquiryImageButtonBorderButtom)
        view.addSubview(appInfoImageButton)
        
        setupConstraints()
        setupLayout()
    }
}

extension SideMenuViewController {
    func setupLayout() {
        userProfileImageButton.addTarget(self, action: #selector(navigateToUserProfileViewController(_:)), for: .touchUpInside)
        userProfileImageButton.setTitle(Resourses.string.userProfileButtonTitle, for: .normal)
        userProfileImageButton.setTitleColor(UIColor.gray, for: .normal)
        userProfileImageButtonBorderButtom.backgroundColor = UIColor.gray
        
        historyImageButton.addTarget(self, action: #selector(navigateToHistoryViewController(_ :)), for: .touchUpInside)
        historyImageButton.setTitle(Resourses.string.historyButtonTitle, for: .normal)
        historyImageButton.setTitleColor(UIColor.gray, for: .normal)
        historyImageButtonBorderButtom.backgroundColor = UIColor.gray
    }
}

// MARK: Constraints

extension SideMenuViewController {
    func setupConstraints() {
        
        userProfileImageButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.top.equalTo(view).offset(60)
            make.left.equalTo(view).offset(32)
        }
        
        userProfileImageButtonBorderButtom.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.top.equalTo(userProfileImageButton.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.left.equalTo(view).offset(16)
        }
        
        historyImageButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.top.equalTo(userProfileImageButtonBorderButtom.snp.bottom).offset(16)
            make.left.equalTo(view).offset(32)
        }
        
        historyImageButtonBorderButtom.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.top.equalTo(historyImageButton.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.left.equalTo(view).offset(16)
        }
    }
}

// MARK: Navigator

extension SideMenuViewController { 
    @objc func navigateToHistoryViewController(_ sender: AnyObject) {
        navigationController?.pushViewController(HistoryViewController(), animated: true)
    }
    
    @objc func navigateToUserProfileViewController(_ sender: AnyObject) {
        navigationController?.pushViewController(UserProfileViewController(), animated: true)
    }
}
