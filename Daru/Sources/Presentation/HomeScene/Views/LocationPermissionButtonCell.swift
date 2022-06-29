//
//  LocationPermissionButtonCell.swift
//  Daru
//
//  Created by 재영신 on 2022/06/29.
//

import UIKit
import SnapKit
import Then

protocol LocationPermissionButtonDelegate: AnyObject {
    func locationPermissionButtonDidTap()
}

final class LocationPermissionButtonCell: UICollectionViewCell {
    
    static let identifier = "\(type(of:LocationPermissionButtonCell.self))"
    
    let locationPermissionButton = UIButton().then {
        $0.backgroundColor = .brown1
        $0.setTitle("나의 위치 알려주기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 19.0
    }
    
    let guideLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .brown1
        $0.text = "현재 위치를 통해서 근처에 있는 찻집을 추천해드려요."
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    weak var delegate: LocationPermissionButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureUI() {
        
        [
            locationPermissionButton,
            guideLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        locationPermissionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40.0)
            make.top.equalToSuperview().inset(38.0)
            make.height.equalTo(38.0)
        }
        locationPermissionButton.addTarget(self, action: #selector(locationPermissionButtonDidTap), for: .touchUpInside)
        
        guideLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalTo(locationPermissionButton.snp.bottom).offset(7.0)
            make.bottom.equalToSuperview()
        }
        
    }
}

private extension LocationPermissionButtonCell {
    @objc func locationPermissionButtonDidTap() {
        delegate?.locationPermissionButtonDidTap()
    }
}
