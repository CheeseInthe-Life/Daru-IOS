//
//  AgreeTermsViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/06/16.
//

import UIKit
import SnapKit
import Then
import ReactorKit

final class AgreeTermsViewController: BaseViewController, View {
    
    private let titleView = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
        $0.text = "개인정보수집 및 이용 동의"
    }
    
    private let termsTitleLabel = UILabel().then {
        $0.text = "이용약관 동의(필수)"
        $0.font = .notoSansKR(.bold, size: 16.0)
    }
    
    private let termsBottomLine = UIView().then {
        $0.backgroundColor = .brown1
    }
    
    private let termsContentTextView = UITextView().then {
        $0.textColor = .gray2
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray4?.cgColor
        $0.isEditable = false
    }
    
    private let termsContentBottomLine = UIView().then {
        $0.backgroundColor = .brown1
    }
    
    private let termsCheckbox = UIImageView(image: Constant.notCheckedBoxIcon)
    
    private let termsAgreementLabel = UILabel().then {
        $0.text = "위의 이용약관에 동의합니다."
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray1
    }
    
    private let termsAgreementView = UIView()
    
    ///Personal Information Collection and Use Agreement
    private let picuaTitleLabel = UILabel().then {
        $0.text = "개인정보수집 및 이용에 대한 안내(필수)"
        $0.font = .notoSansKR(.bold, size: 16.0)
    }
    
    private let picuaBottomLine = UIView().then {
        $0.backgroundColor = .brown1
    }
    
    private let picuaContentTextView = UITextView().then {
        $0.textColor = .gray2
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray4?.cgColor
        $0.isEditable = false
    }
    
    private let picuaContentBottomLine = UIView().then {
        $0.backgroundColor = .brown1
    }
    
    private let picuaCheckbox = UIImageView(image: Constant.notCheckedBoxIcon)
    
    private let picuaAgreementLabel = UILabel().then {
        $0.text = "위의 이용약관에 동의합니다."
        $0.font = .notoSansKR(.regular, size: 14.0)
        $0.textColor = .gray1
    }
    
    private let picuaAgreementView = UIView()
    
    private let allAgreementCheckbox = UIImageView(image: Constant.notCheckedBoxIcon)
    
    private let allAgreementLabel = UILabel().then {
        $0.text = "모든 약관에 동의합니다."
        $0.font = .notoSansKR(.bold, size: 16.0)
    }
    
    private let allAgreementView = UIView().then {
        $0.backgroundColor = .gray6
    }
    
    private let nextButton = PrimaryButton().then {
        $0.setTitle("다음", for: .normal)
    }
    
    init(reactor: AgreeTermsReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        
        [
            termsTitleLabel,
            termsBottomLine,
            termsContentTextView,
            termsContentBottomLine,
            termsAgreementView,
            picuaTitleLabel,
            picuaBottomLine,
            picuaContentTextView,
            picuaContentBottomLine,
            picuaAgreementView,
            allAgreementView,
            nextButton
        ].forEach {
            view.addSubview($0)
        }
        
        [
            termsCheckbox,
            termsAgreementLabel
        ].forEach {
            termsAgreementView.addSubview($0)
        }
        
        [
            picuaCheckbox,
            picuaAgreementLabel
        ].forEach {
            picuaAgreementView.addSubview($0)
        }
        
        [
            allAgreementCheckbox,
            allAgreementLabel
        ].forEach {
            allAgreementView.addSubview($0)
        }
        
        termsTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(28.0)
        }
        
        termsBottomLine.snp.makeConstraints { make in
            make.height.equalTo(2.0)
            make.leading.trailing.equalTo(termsTitleLabel)
            make.top.equalTo(termsTitleLabel.snp.bottom).offset(10.0)
        }
        
        termsContentTextView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(termsTitleLabel)
            make.top.equalTo(termsBottomLine).offset(14.0)
        }
        
        termsContentBottomLine.snp.makeConstraints { make in
            make.top.equalTo(termsContentTextView.snp.bottom).offset(20.0)
            make.leading.trailing.equalTo(termsContentTextView)
            make.height.equalTo(1.0)
        }
        
        termsAgreementView.snp.makeConstraints { make in
            make.top.equalTo(termsContentBottomLine.snp.bottom).offset(10.0)
            make.trailing.equalTo(termsTitleLabel)
        }
        
        termsAgreementLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        termsCheckbox.snp.makeConstraints { make in
            make.trailing.equalTo(termsAgreementLabel.snp.leading).offset(-10.0)
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(14.0)
            make.width.height.equalTo(25.0)
        }
        
        picuaTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(termsTitleLabel)
            make.top.equalTo(termsAgreementView.snp.bottom).offset(16.0)
        }
        
        picuaBottomLine.snp.makeConstraints { make in
            make.height.equalTo(2.0)
            make.leading.trailing.equalTo(picuaTitleLabel)
            make.top.equalTo(picuaTitleLabel.snp.bottom).offset(10.0)
        }
        
        picuaContentTextView.snp.makeConstraints { make in
            make.height.equalTo(termsContentTextView)
            make.leading.trailing.equalTo(picuaTitleLabel)
            make.top.equalTo(picuaBottomLine).offset(14.0)
        }
        
        picuaContentBottomLine.snp.makeConstraints { make in
            make.top.equalTo(picuaContentTextView.snp.bottom).offset(20.0)
            make.leading.trailing.equalTo(picuaContentTextView)
            make.height.equalTo(1.0)
        }
        
        picuaAgreementView.snp.makeConstraints { make in
            make.top.equalTo(picuaContentBottomLine.snp.bottom).offset(10.0)
            make.trailing.equalTo(picuaTitleLabel)
        }
        
        picuaAgreementLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        picuaCheckbox.snp.makeConstraints { make in
            make.trailing.equalTo(picuaAgreementLabel.snp.leading).offset(-10.0)
            make.top.bottom.equalToSuperview().inset(14.0)
            make.leading.equalToSuperview()
            make.width.height.equalTo(25.0)
        }
        
        allAgreementCheckbox.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10.0)
            make.leading.equalToSuperview().inset(25.0)
            make.width.height.equalTo(25.0)
        }
        
        allAgreementLabel.snp.makeConstraints { make in
            make.leading.equalTo(allAgreementCheckbox.snp.trailing).offset(10.0)
            make.centerY.equalToSuperview()
        }
        
        allAgreementView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.top.equalTo(picuaAgreementView.snp.bottom).offset(16.0)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50.0)
            make.height.equalTo(50.0)
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.top.equalTo(allAgreementView.snp.bottom).offset(30.0)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    func bind(reactor: AgreeTermsReactor) {
        
    }
}
