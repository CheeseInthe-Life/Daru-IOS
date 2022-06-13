//
//  LoginButtonCell.swift
//  Daru
//
//  Created by 재영신 on 2022/06/13.
//

import UIKit
import SnapKit
import Then

enum loginType: String {
    case apple
    case kakao
}

protocol LoginButtonDelegate: AnyObject {
    func loginButtonDidtap(type: loginType)
}

final class LoginButtonCell: UICollectionViewCell {
    
    static let identifier = "\(type(of: LoginButtonCell.self))"
    
    private let kakaoButton = UIButton().then {
        $0.setImage(Constant.kakaoIcon, for: .normal)
        $0.setTitle("카카오로 로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor(hex: "#FFEB00")
        $0.layer.cornerRadius = 3.0
        $0.titleLabel?.font = .notoSansKR(.bold, size: 16.0)
        $0.imageEdgeInsets = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
    }
    
    
    private let appleButton = UIButton().then {
        let logo = UIImage.resizeImage(image: Constant.appleIcon, targetHeight: 45.0)
        $0.setImage(logo, for: .normal)
        $0.setTitle("Apple로 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 3.0
        $0.titleLabel?.font = .notoSansKR(.bold, size: 16.0)
        $0.imageEdgeInsets = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
    }
    
    private let guideLabel = UILabel().then {
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .brown1
        $0.text = "로그인을 하셔야 이용할 수 있습니다."
        $0.textAlignment = .center
    }
    
    weak var delegate: LoginButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        [
            appleButton,
            kakaoButton,
            guideLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        appleButton.snp.makeConstraints { make in
            make.width.equalTo(255.0)
            make.height.equalTo(45.0)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20.0)
        }
        
        kakaoButton.snp.makeConstraints { make in
            make.width.height.equalTo(appleButton)
            make.top.equalTo(appleButton.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.top.equalTo(kakaoButton.snp.bottom).offset(8.0)
        }
        
        kakaoButton.addTarget(self, action: #selector(loginButtonDidTap(sender:)), for: .touchUpInside)
    }
}

private extension LoginButtonCell {
    @objc func loginButtonDidTap(sender: UIButton) {
        if sender == kakaoButton {
            delegate?.loginButtonDidtap(type: .kakao)
        } else {
            delegate?.loginButtonDidtap(type: .apple)
        }
    }
}
