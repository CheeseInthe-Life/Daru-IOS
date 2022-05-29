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
import RxDataSources

final class ManagePostViewController: BaseViewController, Stepper {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(ManagePostCommunityCell.self, forCellWithReuseIdentifier: ManagePostCommunityCell.identifier)
        $0.register(ManagePostCommunitySectionHeaderCell.self, forCellWithReuseIdentifier: ManagePostCommunitySectionHeaderCell.identifier)
    }
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,ManagePostItemType>> {
        dataSource, collectionView, indexPath, item in
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ManagePostCommunitySectionHeaderCell.identifier,
                for: indexPath
            ) as! ManagePostCommunitySectionHeaderCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ManagePostCommunityCell.identifier,
                for: indexPath
            ) as! ManagePostCommunityCell
            cell.update(with: item)
            return cell
        default:
            return UICollectionViewCell()
        }
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
        let layout = createLayout()
        layout.register(
            ManagePostCommunitySectionBackgroundView.self,
            forDecorationViewOfKind: ManagePostCommunitySectionBackgroundView.identifier
        )
        mainCollectionView.collectionViewLayout = layout
        
        //TODO: 나중에 SectionModel MultiItem으로 변경
        Observable.just(ManagePostItemType.allCases)
            .map {
                [
                    SectionModel<String,ManagePostItemType>(model: "", items: [.communityRole]),
                    SectionModel<String,ManagePostItemType>(model: "", items: $0)
                ]
            }.bind(to: mainCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
}


// MARK: - CollectionView Layout
private extension ManagePostViewController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createCommunityHeaderSection()
            case 1:
                return self?.createCommunitySection()
            default:
                return nil
            }
        }
    }
    
    func createCommunitySection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.202))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: ManagePostCommunitySectionBackgroundView.identifier)
        ]
        return section
    }
    
    func createCommunityHeaderSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
