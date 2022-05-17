//
//  HomeViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit
import RxFlow
import RxCocoa

final class HomeViewController: BaseViewController, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func bindAction() {
        super.bindAction()
    }
    
    override func bindState() {
        super.bindState()
    }
}
