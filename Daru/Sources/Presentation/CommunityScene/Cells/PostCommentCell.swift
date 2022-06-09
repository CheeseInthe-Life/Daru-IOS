//
//  PostCommentCell.swift
//  Daru
//
//  Created by 재영신 on 2022/06/09.
//

import UIKit
import SnapKit
import Then

final class PostCommentCell: UICollectionViewCell {
    
    static let identifier = "\(type(of: PostCommentCell.self))"
    
    private let topView = UIView()
    
    private let creationTimeLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 14.0)
        $0.textColor = .yellowGreen2
        $0.text = "1분 전"
    }
    
    private let writerIconImageView = UIImageView().then {
        $0.image = Constant.frogIcon
    }
    
    private let writerNameLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 16.0)
        $0.text = "작성자 이름"
    }
    
    private let likeImageView = UIImageView().then {
        $0.image = Constant.likeIcon
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .brown1
    }
    
    private let likeCountLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.text = "123"
    }
    
    private let menuButton = UIButton().then {
        $0.setImage(Constant.menuIcon, for: .normal)
    }
    
    private let contentLabel = UITextView().then {
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.font = .notoSansKR(.regular, size: 12.0)
        $0.text = "본문본문본문본문본문본문본문본문본문본문본문본문본문본문본본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문본문"
        $0.textContainerInset = .init(top: 10.0, left: 0.0, bottom: 13.0, right: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentLabel.layer.addBorder([.top, .bottom], color: .gray5!, width: 1.0)
    }
    
    private func configureUI() {
        
        [
            writerIconImageView,
            writerNameLabel,
            creationTimeLabel,
            likeImageView,
            likeCountLabel,
            menuButton
        ].forEach {
            topView.addSubview($0)
        }
        
        [
            topView,
            contentLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        topView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview()
        }
        
        writerIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24.0)
        }
        
        writerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(writerIconImageView.snp.trailing).offset(5.0)
            make.top.bottom.equalToSuperview().inset(8.0)
        }
        
        creationTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(writerNameLabel.snp.trailing).offset(5.0)
            make.centerY.equalToSuperview()
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.height.equalTo(30.0)
            make.top.bottom.equalToSuperview().inset(10.0)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(menuButton.snp.leading).offset(-5.0)
            make.centerY.equalToSuperview()
        }
        
        likeImageView.snp.makeConstraints { make in
            make.trailing.equalTo(likeCountLabel.snp.leading).offset(-5.0)
            make.centerY.equalToSuperview()
            make.width.equalTo(15.0)
            make.height.equalTo(13.0)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(topView)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
