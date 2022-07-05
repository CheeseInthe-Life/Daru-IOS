//
//  TeahouseDetailAddressCell.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import UIKit
import SnapKit
import Then

final class TeahouseDetailAddressCell: UICollectionViewCell {
    
    static let identifier = "\(type(of: TeahouseDetailAddressCell.self))"
    
    private let addressLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.text = "서울특별시 관악구 호암로 24길 17 1,2층"
        $0.textAlignment = .center
        $0.textColor = .gray3
        $0.numberOfLines = 2
    }
    
    private let moveMapButton = UIButton().then {
        $0.layer.cornerRadius = 18.0
        $0.backgroundColor = .brown1
        $0.setTitle("지도에서 확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(Constant.mapIcon, for: .normal)
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
            addressLabel,
            moveMapButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(20.0)
        }
        
        moveMapButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80.0)
            make.height.equalTo(36.0)
            make.top.equalTo(addressLabel.snp.bottom).offset(20.0)
            make.bottom.equalToSuperview().inset(30.0)
        }
    }
}
