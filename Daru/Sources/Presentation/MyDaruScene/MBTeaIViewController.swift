//
//  MBTeaIViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/22.
//

import UIKit
import RxFlow
import RxCocoa
import SnapKit
import Then
import RxDataSources
import ReactorKit

final class MBTeaIViewController: BaseViewController, Stepper {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.register(MBTeaIExplainationCell.self, forCellWithReuseIdentifier: MBTeaIExplainationCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,String>> { dataSource, collectionView, indexPath, item in
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MBTeaIExplainationCell.identifier,
                for: indexPath
            ) as! MBTeaIExplainationCell
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
        super.configureUI()
     
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let sectionModels = [
            SectionModel<String,String>(model: "", items: ["d"])
        ]
        
        Observable.just(
            sectionModels
        ).bind(to: mainCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainCollectionView.collectionViewLayout = createLayout()
    }
}

private extension MBTeaIViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createMBteaIExplainationSection()
            default:
                return nil
            }
        }
    }
    
    func createMBteaIExplainationSection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 0.0, bottom: 0, trailing: 0.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.257))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        //section.contentInsets = .init(top: 42.0, leading: 0, bottom: 20.0, trailing: 0)
        
        return section
    }
}
