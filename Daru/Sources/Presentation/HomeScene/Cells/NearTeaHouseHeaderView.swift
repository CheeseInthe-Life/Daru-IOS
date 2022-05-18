//
//  NearByTeaHouseCell.swift
//  Daru
//
//  Created by 재영신 on 2022/05/18.
//

import UIKit
import SnapKit
import Then

final class NearTeaHouseHeaderView: UICollectionReusableView {
    static let identifier = "NearTeaHouseHeaderView"

    private let titleLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.text = "내 주변 찻집"
    }
    
    private let secondaryLabel = UILabel().then {
        $0.font = .notoSansKR(.medium, size: 14.0)
        $0.text = "현재 위치 : 서울, 관악구"
    }
    
    private let locationImageView = UIImageView().then {
        $0.image = Constant.frogIcon
        $0.contentMode = .scaleAspectFit
    }
    
    private let moreButton = UIButton().then {
        $0.setImage(Constant.arrowIcon, for: .normal)
        $0.tintColor = .gray2
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .notoSansKR(.regular, size: 12.0)
        $0.imageEdgeInsets = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 6.0)
        $0.layer.borderColor = UIColor.gray4?.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 4.0
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
            titleLabel,
            secondaryLabel,
            locationImageView,
            moreButton
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35.0)
            make.trailing.equalTo(moreButton.snp.leading)
            make.leading.equalToSuperview().inset(20.0)
        }
        
        secondaryLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationImageView.snp.trailing).offset(8.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(7.0)
            make.bottom.equalToSuperview()
        }
        
        locationImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.bottom.equalTo(secondaryLabel)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20.0)
            make.width.equalTo(64.0)
            make.height.equalTo(24.0)
            make.top.equalTo(titleLabel)
        }
    }
}
