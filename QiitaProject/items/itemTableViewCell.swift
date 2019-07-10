//
//  itemTableViewCell.swift
//  QiitaProject
//
//  Created by 鈴木友也 on 2019/07/03.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import Nuke
import SnapKit

class itemTableViewCell: UITableViewCell {
    static let cellHeigth: CGFloat = 200.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private lazy var titleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var tagTitleLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var tagDescriptionLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var createdAtLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var userNameLabel: UILabel = {
        UILabel()
    }()
    
    private lazy var userImageView: UIImageView = {
        UIImageView()
    }()
    
    // - initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // セルの選択カラーをなくす
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagTitleLabel)
        contentView.addSubview(tagDescriptionLabel)
        contentView.addSubview(createdAtLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userImageView)
        
        setupUIComponents()
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - bind
    
    func bind(items: [Item], indexPath: IndexPath) {
        // タイトル
        titleLabel.text = items[indexPath.row].title
        // タグタイトル
        tagTitleLabel.text = Resourses.string.tagTitle
        // 作成者名
        userNameLabel.text = items[indexPath.row].user?.name
        // タグ
        if let tags = items[indexPath.row].tags {
            tagDescriptionLabel.text = tagDescription(tags: tags)
        } else {
            tagDescriptionLabel.text = Resourses.string.tagEmptyDescription
        }
        // 作成日時
        createdAtLabel.text = items[indexPath.row].createdAt.toDate().toString()
        // プロフィール写真
        if let profileImageURL = items[indexPath.row].user?.profileImageUrl {
            Nuke.loadImage(with: URL(string: profileImageURL)!, into: userImageView)
        } else {
            userImageView.backgroundColor = UIColor.gray
        }
    }
    
    // - UIComponent
    
    private func setupUIComponents() {
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping
        
        tagTitleLabel.textColor = UIColor.gray
        tagTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        tagDescriptionLabel.numberOfLines = 0
        tagDescriptionLabel.lineBreakMode = .byCharWrapping
        tagDescriptionLabel.textColor = UIColor.gray
        tagDescriptionLabel.font = createdAtLabel.font.withSize(14)
        
        createdAtLabel.textColor = UIColor.gray
        createdAtLabel.font = createdAtLabel.font.withSize(14)
        
        userImageView.backgroundColor = UIColor.gray
    }
    
    // - constraint
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(40)
            make.right.equalTo(contentView).offset(-32)
            make.left.equalTo(contentView).offset(32)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-32)
        }

        tagTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(32)
        }

        tagDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tagTitleLabel.snp.bottom).offset(8)
            make.right.equalTo(contentView).offset(-32)
            make.left.equalTo(tagTitleLabel)
        }

        userImageView.snp.remakeConstraints { make in
            make.size.equalTo(CGSize(width: 30.0, height: 30.0))
            make.top.equalTo(tagDescriptionLabel.snp.bottom).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
            make.left.equalTo(contentView).offset(32)
        }

        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(16)
        }
    }
    
    // - function
    
    private func tagDescription(tags: [Tag]) -> String {
        var tagNames: [String] = []
        var tagDescription: String = ""
        
        for tag in tags {
            guard let tagName = tag.name else { return "" }
            tagNames.append(tagName)
        }
        
        tagDescription = tagNames.joined(separator: " , ")
        
        return tagDescription
    }
}
