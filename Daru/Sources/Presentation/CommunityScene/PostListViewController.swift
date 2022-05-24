//
//  CommunityViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/25.
//

import UIKit
import SnapKit
import Then
import RxFlow
import RxSwift
import RxCocoa

final class PostListViewController: BaseViewController, Stepper {
    
    private let writeButton = UIButton().then {
        $0.backgroundColor = .brown2
        $0.layer.cornerRadius = 4.0
        $0.setTitle("글 작성하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let postListTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    var steps: PublishRelay<Step> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        
        [
            writeButton,
            postListTableView
        ].forEach {
            view.addSubview($0)
        }
        
        writeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().inset(15.0)
            make.width.equalTo(88.0)
            make.height.equalTo(25.0)
        }
        
        postListTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(writeButton.snp.bottom).offset(14.0)
        }
    }
}
