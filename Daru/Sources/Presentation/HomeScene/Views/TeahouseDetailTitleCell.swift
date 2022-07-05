//
//  TeahouseDetailTitleCell.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import UIKit
import SnapKit
import Then

final class TeahouseDetailTitleCell: UICollectionViewCell {
    
    static let identifier = "\(type(of: TeahouseDetailTitleCell.self))"
    
    let backgroudImageView = UIImageView(image: Constant.dummyTeahouseBackgroudImage)
    
    let titleView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 6.0
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowRadius = 4.0
        $0.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
    }
    
    let nameLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 20.0)
        $0.textAlignment = .center
        $0.text = "티하우스"
    }
    
    let tagLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray3
        $0.text = "#다섯글자요 #다섯글자요 #다섯글자요 #다섯글자요"
    }
    
    let ratingPrefixLabel = UILabel().then {
        $0.text = "평점:"
        $0.font = .notoSansKR(.medium, size: 12.0)
        $0.textColor = .gray2
    }
    
    let ratingImageStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.alignment = .fill
    }
    
    let ratingNumberLabel = UILabel().then {
        $0.text = "4.2"
        $0.font = .notoSansKR(.medium, size: 12.0)
        $0.textColor = .gray2
    }
    
    let ratingView = UIView()
    
    let dividingLine = UIView().then {
        $0.backgroundColor = .brown3
    }
    
    let likeItemView = CommonItemView().then {
        $0.update(with: Constant.likeIcon2, "23000")
    }
    
    let instagramItemView = CommonItemView().then {
        $0.update(with: Constant.instagramIcon, "인스타그램")
    }
    
    let homepageItemView = CommonItemView().then {
        $0.update(with: Constant.homepageIcon, "홈페이지")
    }
    
    let shareItemView = CommonItemView().then {
        $0.update(with: Constant.shareIcon, "공유하기")
    }
    
    let itemStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 24.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        [
            likeItemView,
            instagramItemView,
            homepageItemView,
            shareItemView
        ].forEach {
            itemStackView.addArrangedSubview($0)
        }
        
        [
            nameLabel,
            tagLabel,
            ratingView,
            dividingLine,
            itemStackView
        ].forEach {
            titleView.addSubview($0)
        }
        
        [
            ratingPrefixLabel,
            ratingImageStackView,
            ratingNumberLabel
        ].forEach {
            ratingView.addSubview($0)
        }
        
        [
            backgroudImageView,
            titleView
        ].forEach {
            contentView.addSubview($0)
        }
        
        //TODO: Delete
        for _ in 0 ..< 5 {
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.tintColor = .brown1
            imageView.contentMode = .scaleAspectFit
            ratingImageStackView.addArrangedSubview(imageView)
        }
        
        backgroudImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.66)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(backgroudImageView.snp.bottom).offset(-60.0)
            make.leading.trailing.equalToSuperview().inset(30.0)
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(13.0)
        }
        nameLabel.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        
        tagLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8.0)
            make.top.equalTo(nameLabel.snp.bottom)
        }
        
        ratingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tagLabel.snp.bottom).offset(4.0)
        }
        
        ratingPrefixLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        ratingImageStackView.snp.makeConstraints { make in
            make.leading.equalTo(ratingPrefixLabel.snp.trailing).offset(4.0)
            make.trailing.equalTo(ratingNumberLabel.snp.leading).offset(-4.0)
            make.top.bottom.equalToSuperview()
        }
        
        ratingNumberLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        dividingLine.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(10.0)
            make.leading.trailing.equalToSuperview().inset(18.0)
            make.height.equalTo(1.0)
        }
        
        itemStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(dividingLine)
            make.top.equalTo(dividingLine.snp.bottom).offset(10.0)
            make.bottom.equalToSuperview().inset(15.0)
        }
    }
}
