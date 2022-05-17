//
//  RecommendTeaHouseCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit
import SnapKit
import Then

final class RecommendTeaHouseCell: UICollectionViewCell {
    
    static let identifier = "RecommendTeaHouseCell"
    
    private let teaHouseImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 10.0
        $0.image = Constant.dummyTeaHouseImage
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "찻집 이름"
        $0.font = .notoSansKR(.bold, size: 14.0)
    }
    
    private let tagLabel = UILabel().then {
        $0.text = "#전통 찻집#녹차#백차#우롱차"
        $0.font = .notoSansKR(.regular, size: 10.0)
        $0.textColor = .gray2
    }
    
    private let locationLabel = UILabel().then {
        $0.text = "관악구 관악로1"
        $0.font = .notoSansKR(.regular, size: 12.0)
        $0.textColor = .gray2
    }
    
    private let distanceLabel = UILabel().then {
        $0.text = "3.2km"
        $0.font = .notoSansKR(.regular, size: 12.0)
        $0.textColor = .gray2
    }
    
    private let distanceImageView = UIImageView().then {
        $0.image = Constant.distanceIcon
        $0.contentMode = .scaleAspectFit
    }
    
    private let ratingLabel = UILabel().then {
        $0.text = "평점 : "
        $0.font = .notoSansKR(.medium, size: 12.0)
        $0.textColor = .gray2
    }
    
    private let ratingStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.alignment = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        
        [
            teaHouseImageView,
            nameLabel,
            tagLabel,
            locationLabel,
            distanceLabel,
            distanceImageView,
            ratingLabel,
            ratingStackView
        ].forEach {
            contentView.addSubview($0)
        }
        
        contentView.layer.cornerRadius = 12.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.brown3?.cgColor
        
        for _ in 0 ..< 5 {
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.tintColor = .brown1
            imageView.contentMode = .scaleAspectFit
            ratingStackView.addArrangedSubview(imageView)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.leading.equalTo(ratingLabel.snp.trailing).offset(2.0)
            make.top.bottom.equalTo(ratingLabel)
            make.trailing.equalToSuperview().inset(55.0)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.width.equalTo(ratingLabel.intrinsicContentSize.width)
            make.bottom.equalToSuperview().inset(14.0)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.bottom.equalTo(ratingLabel.snp.top).offset(-5.0)
            make.width.equalTo(distanceLabel.intrinsicContentSize.width)
        }
        
        distanceImageView.snp.makeConstraints { make in
            make.leading.equalTo(distanceLabel.snp.trailing).offset(2.0)
            make.top.bottom.equalTo(distanceLabel)
            make.width.equalTo(10.0)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.bottom.equalTo(distanceLabel.snp.top).offset(-5.0)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.bottom.equalTo(locationLabel.snp.top).offset(-8.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(11.0)
            make.bottom.equalTo(tagLabel.snp.top).offset(-4.0)
        }
        
        teaHouseImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10.0)
            make.top.equalToSuperview().inset(12.0)
            make.bottom.equalTo(nameLabel.snp.top).offset(-11.0)
        }
        
        teaHouseImageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        teaHouseImageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
    }
}
