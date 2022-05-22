//
//  MBTeaIViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import UIKit
import RxFlow
import RxCocoa
import SnapKit
import Then

final class MBTeaIViewController: BaseViewController, Stepper {
    
    private let mainLabel = UILabel().then {
        $0.font = .notoSansKR(.bold, size: 20.0)
        $0.text = "MB.Tea.I란?"
        $0.textAlignment = .center
    }
    
    var steps: PublishRelay<Step> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        
        [
            mainLabel
        ].forEach {
            view.addSubview($0)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18.0)
            make.top.equalToSuperview().inset(20.0)
        }
    }
}
