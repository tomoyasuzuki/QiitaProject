//
//  SideMenuViewController.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    // - Property
    
    private let buttonHeight: CGFloat = 30.0
    private let iconImageViewHeight: CGFloat = 36.0
    
    // - View
    
    private lazy var loginImageButton: UIButton = {
        UIButton()
    }()
    
    private lazy var loginImageButtonBorderButtom: UIView = {
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
    
    // - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(loginImageButton)
        view.addSubview(loginImageButtonBorderButtom)
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
        loginImageButton.addTarget(self, action: #selector(navigateToLoginViewController(_ :)), for: .touchUpInside)
        loginImageButton.setTitle(Resourses.string.loginButtonTitle, for: .normal)
        loginImageButton.setTitleColor(UIColor.gray, for: .normal)
        
        loginImageButtonBorderButtom.backgroundColor = UIColor.gray
        
        historyImageButton.addTarget(self, action: #selector(navigateToHistoryViewController(_ :)), for: .touchUpInside)
        historyImageButton.setTitle(Resourses.string.historyButtonTitle, for: .normal)
        historyImageButton.setTitleColor(UIColor.gray, for: .normal)
        
        historyImageButtonBorderButtom.backgroundColor = UIColor.gray
    }
}

// - Constraints

extension SideMenuViewController {
    func setupConstraints() {
        
        loginImageButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.top.equalTo(view).offset(48)
            make.left.equalTo(view).offset(32)
        }
        
        loginImageButtonBorderButtom.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.top.equalTo(loginImageButton.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.left.equalTo(view).offset(16)
        }
        
        historyImageButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.top.equalTo(loginImageButtonBorderButtom.snp.bottom).offset(32)
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

// Navigator

extension SideMenuViewController {
    @objc func navigateToLoginViewController(_ sender: AnyObject) {
        navigationController?.pushViewController(UserProfileViewController(), animated: true)
    }
    
    @objc func navigateToHistoryViewController(_ sender: AnyObject) {
        navigationController?.pushViewController(HistoryViewController(), animated: true)
    }
}
