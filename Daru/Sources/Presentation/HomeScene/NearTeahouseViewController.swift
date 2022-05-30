//
//  NearTeahouseViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/29.
//

import UIKit
import SnapKit
import Then
import ReactorKit

final class NearTeahouseViewController: BaseViewController, View {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
    }
    
    init(reactor: NearTeahouseReactor) {
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
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func bind(reactor: NearTeahouseReactor) {
        
    }
}
