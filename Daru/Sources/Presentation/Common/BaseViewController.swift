//
//  BaseViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/16.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

}
