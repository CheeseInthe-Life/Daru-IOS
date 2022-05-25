//
//  HomeViewController.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import UIKit
import RxFlow
import RxCocoa
import ReactorKit
import RxDataSources

final class HomeViewController: BaseViewController, Stepper, View {
    
    var steps: PublishRelay<Step> = .init()
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        $0.register(TeaHouseCell.self, forCellWithReuseIdentifier: TeaHouseCell.identifier)
        $0.register(
            RecommendTeaHouseHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RecommendTeaHouseHeaderView.identifier
        )
        $0.register(
            RecommendTeaHouseFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RecommendTeaHouseFooterView.identifier
        )
        $0.register(
            NearTeaHouseHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NearTeaHouseHeaderView.identifier
        )
        $0.register(PostCollectionViewCell.self,forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        $0.register(
            RecentPostHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RecentPostHeaderView.identifier
        )
        $0.register(RegionCategoryCell.self, forCellWithReuseIdentifier: RegionCategoryCell.identifier)
        $0.register(
            RegionCategoryHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RegionCategoryHeaderView.identifier
        )
        $0.register(HomeFooterCell.self, forCellWithReuseIdentifier: HomeFooterCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,String>> {
        datasource, collectionView, indexPath, item in
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath
            ) as! BannerCell
            cell.update(with: [Constant.banner!, Constant.banner!, Constant.banner!])
            return cell
        case 1, 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TeaHouseCell.identifier,
                for: indexPath
            ) as! TeaHouseCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath
            ) as! PostCollectionViewCell
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RegionCategoryCell.identifier,
                for: indexPath
            ) as! RegionCategoryCell
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeFooterCell.identifier,
                for: indexPath
            ) as! HomeFooterCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }configureSupplementaryView: { dataSource, collectionView, type, indexPath in
        if indexPath.section == 1 {
            if type == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: RecommendTeaHouseHeaderView.identifier,
                    for: indexPath
                ) as! RecommendTeaHouseHeaderView
                return view
            } else {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: RecommendTeaHouseFooterView.identifier,
                    for: indexPath
                ) as! RecommendTeaHouseFooterView
                return view
            }
        } else if indexPath.section == 2 {
            if type == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: NearTeaHouseHeaderView.identifier,
                    for: indexPath
                ) as! NearTeaHouseHeaderView
                return view
            }
        } else if indexPath.section == 3 {
            if type == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: RecentPostHeaderView.identifier,
                    for: indexPath
                ) as! RecentPostHeaderView
                return view
            }
        } else if indexPath.section == 4 {
            if type == UICollectionView.elementKindSectionHeader {
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: RegionCategoryHeaderView.identifier,
                    for: indexPath
                ) as! RegionCategoryHeaderView
                return view
            }
        }
        return UICollectionReusableView()
    }
    
    init(reactor: HomeReactor) {
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
        
        let layout = createLayout()
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainCollectionView.collectionViewLayout = layout
    }
    
    func bind(reactor: HomeReactor) {
        let sections = [
            SectionModel(model: "", items: ["dfasfds"]),
            SectionModel(model: "", items: ["afsd","Fsdaf","fdsafdsa","fdsafdsa","Fsadfsda"]),
            SectionModel(model: "", items: ["fdasf","Fsadf","Fsdafasd","fsdafa",]),
            SectionModel(model: "", items: ["fdasf","Fsadf"]),
            SectionModel(model: "", items: ["fdasf","Fsadf","FADS","dfa","Fadsfasd","fads","DFas","Adsf","ASDf"]),
            SectionModel(model: "", items: ["fasd"])
        ]
        
        Observable.just(sections)
            .bind(to: mainCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}

private extension HomeViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createRecommendTeaHouseSection()
            case 2:
                return self?.createNearTeaHouseSection()
            case 3:
                return self?.createRecentPostSection()
            case 4:
                return self?.createRegionCategorySection()
            case 5:
                return self?.createHoomFooterSection()
            default:
                return nil
            }
        }
    }
    
    func createBannerSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 0.0, bottom: 0, trailing: 0.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.203))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 42.0, leading: 0, bottom: 20.0, trailing: 0)
        
        return section
    }
    
    func createRecommendTeaHouseSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 20.0, bottom: 0, trailing: 20.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.353))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10.0)
        group.contentInsets = .init(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 0.0)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            createRecommendTeaHouseSectionHeader(),
            createRecommendTeaHouseSectionFooter()
        ]
        section.contentInsets = .init(top: 18.0, leading: 10.0, bottom: 15.0, trailing: 0)
        
        return section
    }
    
    private func createRecommendTeaHouseSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(46.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        //sectionHeader.contentInsets = .init(top: 0, leading: 20.0, bottom: 0, trailing: 0)
        return sectionHeader
    }
    
    private func createRecommendTeaHouseSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(10.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)
        return sectionHeader
    }
    
    func createNearTeaHouseSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 20.0, bottom: 0, trailing: 20.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.353))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10.0)
        group.contentInsets = .init(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 0.0)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            createNearTeaHouseSectionHeader()
        ]
        section.contentInsets = .init(top: 18.0, leading: 10.0, bottom: 15.0, trailing: 0)
        
        return section
    }
    
    private func createNearTeaHouseSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(46.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    
    func createRecentPostSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0.0, bottom: 20.0, trailing: 0.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(192.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            createRecentPostSectionHeader()
        ]
        section.contentInsets = .init(top: 18.0, leading: 20.0, bottom: 0.0, trailing: 20.0)
        
        return section
    }
    
    func createRecentPostSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(46.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    
    func createRegionCategorySection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(16.0)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            createRecentPostSectionHeader()
        ]
        section.contentInsets = .init(top: 18.0, leading: 20.0, bottom: 15.0, trailing: 20.0)
        
        return section
    }
    
     func createRegionCategorySectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(46.0))
        
        //Section Header layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    
    func createHoomFooterSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
