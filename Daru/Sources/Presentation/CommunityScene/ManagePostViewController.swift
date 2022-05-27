//
//  ManagePostViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/25.
//

import UIKit
import SnapKit
import Then
import RxFlow
import RxCocoa
import RxSwift

final class ManagePostViewController: BaseViewController, Stepper {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
    }
    
    var steps: PublishRelay<Step> = .init()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
