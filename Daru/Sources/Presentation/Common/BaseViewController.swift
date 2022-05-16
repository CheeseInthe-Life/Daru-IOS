//
//  BaseViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindAction()
        bindState()
    }
    
    func configureUI() {
        
    }
    
    func bindAction() {
        
    }
    
    func bindState() {
        
    }
}
