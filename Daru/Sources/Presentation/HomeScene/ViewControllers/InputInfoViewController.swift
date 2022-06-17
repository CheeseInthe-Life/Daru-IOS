//
//  InputInfoViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import UIKit
import SnapKit
import Then
import ReactorKit

final class InputInfoViewController: BaseViewController, View {
    
    private let nickNameTitleLabel = UILabel().then {
        $0.text = "닉네임(최소 2자, 최대 10자)"
        $0.font = .notoSansKR(.bold, size: 16.0)
    }
    
    private let nickNameTextField = PaddingTextField().then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown2?.cgColor
        $0.layer.cornerRadius = 10.0
        $0.padding = .init(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
        $0.textAlignment = .center
    }
    
    private let duplicateCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .brown1
        $0.layer.cornerRadius = 4.0
    }
    
    private let duplicateCheckLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 12.0)
        $0.isHidden = true
        $0.text = "※ 사용 가능한 닉네임입니다."
    }
    
    private let dateOfBirthTitleLabel = UILabel().then {
        $0.text = "생년월일"
        $0.font = .notoSansKR(.bold, size: 16.0)
    }
    
    private let dateOfBirthTextField = PaddingTextField().then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown2?.cgColor
        $0.layer.cornerRadius = 10.0
        $0.padding = .init(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
        $0.textAlignment = .center
    }
    
    private let genderTitleLabel = UILabel().then {
        $0.text = "성별"
        $0.font = .notoSansKR(.bold, size: 16.0)
    }
    
    private let maleButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown2?.cgColor
        $0.layer.cornerRadius = 10.0
        $0.setTitle("남", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .notoSansKR(.regular, size: 16.0)
    }
    
    private let femaleButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown2?.cgColor
        $0.layer.cornerRadius = 10.0
        $0.setTitle("여", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .notoSansKR(.regular, size: 16.0)
    }
    
    private let genderButtonStackView = UIStackView().then {
        $0.spacing = 39.0
        $0.distribution = .fillEqually
    }
    
    private let notSelectGengerButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.brown2?.cgColor
        $0.layer.cornerRadius = 10.0
        $0.setTitle("지정하지 않기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .notoSansKR(.regular, size: 16.0)
    }
    
    private let startButton = PrimaryButton().then {
        $0.setTitle("다루 시작하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .gray4
        $0.isEnabled = false
    }
    
    private let titleView = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 18.0)
        $0.textColor = .tit_brwon
        $0.text = "기본 정보 입력"
    }
    
    private let inputDatePicker = UIPickerView()
    
    private let years = Array(1950...2022)
    
    init(reactor: InputInfoReactor) {
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
            nickNameTitleLabel,
            nickNameTextField,
            duplicateCheckLabel,
            duplicateCheckButton,
            dateOfBirthTitleLabel,
            dateOfBirthTextField,
            genderTitleLabel,
            genderButtonStackView,
            notSelectGengerButton,
            startButton
        ].forEach {
            view.addSubview($0)
        }
        
        [
            maleButton,
            femaleButton
        ].forEach {
            genderButtonStackView.addArrangedSubview($0)
        }
        
        nickNameTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(34.0)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(29.0)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nickNameTitleLabel)
            make.top.equalTo(nickNameTitleLabel.snp.bottom).offset(15.0)
        }
        nickNameTextField.delegate = self
        
        duplicateCheckLabel.snp.makeConstraints { make in
            make.leading.equalTo(nickNameTextField)
            make.top.equalTo(nickNameTextField.snp.bottom).offset(7.0)
            make.trailing.equalTo(duplicateCheckButton.snp.leading).offset(-12.0)
        }
        
        duplicateCheckButton.snp.makeConstraints { make in
            make.trailing.equalTo(nickNameTextField)
            make.top.equalTo(nickNameTextField.snp.bottom).offset(7.0)
            make.width.equalTo(88.0)
            make.height.equalTo(24.0)
        }
        
        dateOfBirthTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(duplicateCheckLabel.snp.bottom).offset(10.0)
            make.leading.trailing.equalTo(nickNameTitleLabel)
        }
        
        dateOfBirthTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nickNameTitleLabel)
            make.top.equalTo(dateOfBirthTitleLabel.snp.bottom).offset(15.0)
        }
        inputDatePicker.dataSource = self
        inputDatePicker.delegate = self
        dateOfBirthTextField.inputView = inputDatePicker
        
        genderTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthTextField.snp.bottom).offset(10.0)
            make.leading.trailing.equalTo(nickNameTitleLabel)
        }
        
        genderButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(genderTitleLabel)
            make.height.equalTo(44.0)
            make.top.equalTo(genderTitleLabel.snp.bottom).offset(15.0)
        }
        
        notSelectGengerButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(genderButtonStackView)
            make.height.equalTo(genderButtonStackView)
            make.top.equalTo(genderButtonStackView.snp.bottom).offset(10.0)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.height.equalTo(48.0)
            make.bottom.equalToSuperview().inset(50.0)
        }
        navigationItem.titleView = titleView
    }
    
    func bind(reactor: InputInfoReactor) {
        
        duplicateCheckButton.rx.tap
            .withLatestFrom(nickNameTextField.rx.text.orEmpty)
            .map { Reactor.Action.duplicateCheck(nickname: $0)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        maleButton.rx.tap
            .withUnretained(self)
            .map { _, _ in Reactor.Action.selectGender(gender: .male)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        femaleButton.rx.tap
            .withUnretained(self)
            .map { _, _ in Reactor.Action.selectGender(gender: .female)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        notSelectGengerButton.rx.tap
            .withUnretained(self)
            .map { _, _ in Reactor.Action.selectGender(gender: .notSelectGender)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .map { Reactor.Action.signUp }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.isDuplicated }
            .bind {
                [weak self] isDuplicated in
                
                if let self = self, self.duplicateCheckLabel.isHidden {
                    self.duplicateCheckLabel.isHidden = false
                }
                if isDuplicated{
                    self?.duplicateCheckLabel.textColor = .red
                    self?.duplicateCheckLabel.text = "※ 중복된 닉네임입니다."
                } else {
                    self?.duplicateCheckLabel.textColor = .blueGreen1
                    self?.duplicateCheckLabel.text = "※ 사용 가능한 닉네임입니다."
                }
            }.disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.date }
            .distinctUntilChanged()
            .bind {
                [weak self] date in
                self?.dateOfBirthTextField.text = date
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.gender }
            .skip(until: reactor.action.filter{ if case Reactor.Action.selectGender(_) = $0 {
                return true
            } else {
                return false
            }})
            .distinctUntilChanged()
            .bind {
                [weak self] gender in
                
                switch gender {
                case .male:
                    self?.maleButton.backgroundColor = .brown1
                    self?.maleButton.setTitleColor(.white, for: .normal)
                    self?.femaleButton.backgroundColor = .white
                    self?.femaleButton.setTitleColor(.black, for: .normal)
                    self?.notSelectGengerButton.backgroundColor = .white
                    self?.notSelectGengerButton.setTitleColor(.black, for: .normal)
                case .female:
                    self?.femaleButton.backgroundColor = .brown1
                    self?.femaleButton.setTitleColor(.white, for: .normal)
                    self?.maleButton.backgroundColor = .white
                    self?.maleButton.setTitleColor(.black, for: .normal)
                    self?.notSelectGengerButton.backgroundColor = .white
                    self?.notSelectGengerButton.setTitleColor(.black, for: .normal)
                case .notSelectGender:
                    self?.notSelectGengerButton.backgroundColor = .brown1
                    self?.notSelectGengerButton.setTitleColor(.white, for: .normal)
                    self?.femaleButton.backgroundColor = .white
                    self?.femaleButton.setTitleColor(.black, for: .normal)
                    self?.maleButton.backgroundColor = .white
                    self?.maleButton.setTitleColor(.black, for: .normal)
                default:
                    break
                }
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.isInputCompleted }
            .distinctUntilChanged()
            .bind {
                [weak self] isInputCompleted in
                if isInputCompleted {
                    self?.startButton.backgroundColor = .brown2
                } else {
                    self?.startButton.backgroundColor = .gray4
                }
                self?.startButton.isEnabled = isInputCompleted
            }.disposed(by: disposeBag)
        
        reactor.state.map { $0.isSignUpSuccessed }
            .bind {
                if $0 {
                    print("SignUp Successed!!!!")
                }
            }.disposed(by: disposeBag)
    }
}

extension InputInfoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(years[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reactor?.action.onNext(.inputDateOfBirth(date: "\(years[row])"))
        dateOfBirthTextField.endEditing(true)
    }
}

private extension InputInfoViewController {
    
    @objc func selectToolbarButtonDidTap() {
        
    }
    
}

extension InputInfoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 10 else { return false }
        return true
    }
}
