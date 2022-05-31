//
//  PostDetailViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import UIKit
import SnapKit
import Then
import ReactorKit

final class PostDetailViewController: BaseViewController, View {
    
    init(reactor: PostDetailReactor) {
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
    }
    
    func bind(reactor: PostDetailReactor) {
        
    }
}
