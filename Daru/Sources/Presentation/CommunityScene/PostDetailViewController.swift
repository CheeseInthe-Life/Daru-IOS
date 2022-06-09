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
import Differentiator

final class PostDetailViewController: BaseViewController, View {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: .init()
    ).then {
        $0.register(PostContentCell.self, forCellWithReuseIdentifier: PostContentCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
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
        
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainCollectionView.collectionViewLayout = createLayout()
    }
    
    func bind(reactor: PostDetailReactor) {
        
        Observable.just(
            [SectionModel(model: "", items: ["a"])]
        ).bind(to: mainCollectionView.rx.items(dataSource: PostDetailDataSource.dataSource()))
            .disposed(by: disposeBag)
    }
}

private extension PostDetailViewController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return .init {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createPostContentSection()
            default:
                return nil
            }
        }
    }
    
    func createPostContentSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
