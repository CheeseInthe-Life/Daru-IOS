//
//  TeahouseDetailViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import UIKit
import SnapKit
import Then
import ReactorKit

final class TeahouseDetailViewController: BaseViewController, View {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(TeahouseDetailTitleCell.self, forCellWithReuseIdentifier: TeahouseDetailTitleCell.identifier)
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    init(reactor: TeahouseDetailReactor) {
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
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        mainCollectionView.collectionViewLayout = createCommonLayout()
    }
    
    func bind(reactor: TeahouseDetailReactor) {
        
        // MARK: - Action
        
        
        // MARK: - State
        reactor.pulse(\.$sections)
            .debug()
            .bind(to: mainCollectionView.rx.items(dataSource: TeahouseDetailDataSource.dataSource()))
            .disposed(by: disposeBag)
    }
}

// MARK: - CompositionalLayout Methods
private extension TeahouseDetailViewController {
    func createCommonLayout() -> UICollectionViewCompositionalLayout {
        return .init {
            [weak self] section, envirionment in
            switch section {
            case 0:
                return self?.createTitleSection()
            default:
                return nil
            }
        }
    }
    
    func createTitleSection() -> NSCollectionLayoutSection {
        //0.443
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.443))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
       
        return section
    }
}
