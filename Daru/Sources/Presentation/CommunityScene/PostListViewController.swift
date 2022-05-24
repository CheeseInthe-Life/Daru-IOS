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
    
    var steps: PublishRelay<Step> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
