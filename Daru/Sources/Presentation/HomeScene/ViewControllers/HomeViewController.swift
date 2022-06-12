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

@objc
protocol MoreButtonDelegate: AnyObject {
    func moreButtonDidTap(_ section: Int)
}

final class HomeViewController: BaseViewController, View {
    
    private let mainCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        $0.register(TeaHouseCell.self, forCellWithReuseIdentifier: TeaHouseCell.identifier)
        $0.register(
            HomeRecommendTeaHouseSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeRecommendTeaHouseSectionHeaderView.identifier
        )
        $0.register(
            HomeRecommendTeaHouseSectionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: HomeRecommendTeaHouseSectionFooterView.identifier
        )
        $0.register(
            HomeNearTeaHouseSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeNearTeaHouseSectionHeaderView.identifier
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
        $0.register(LoginButtonCell.self, forCellWithReuseIdentifier: LoginButtonCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    init(reactor: HomeReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(type(of: self)) willAppear")
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(type(of: self)) willDisAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(type(of: self)) \(#function)")
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
    
    func bind(reactor: HomeReactor) {
        
        rx.methodInvoked(#selector(moreButtonDidTap(_:)))
            .map { $0[0] as! Int }
            .map { Reactor.Action.moreButtonDidTap(section: $0) }
            .debug()
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let dataSource = HomeDataSource.dataSource(delegate: self)
        
        reactor.state.map { $0.sections }
            .do {
                if $0[1].items.first == .loginButtonSectionItem {
                    return self.mainCollectionView.collectionViewLayout = self.createNotLoginLayout()
                } else {
                    return self.mainCollectionView.collectionViewLayout = self.createLayout()
                }
            }
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
    
    func createNotLoginLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, environment -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createLoginButtonSection()
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
    
    func createLoginButtonSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 20.0, bottom: 0, trailing: 20.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            createRecommendTeaHouseSectionHeader()
        ]
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 18.0, leading: 0.0, bottom: 15.0, trailing: 0)
        
        return section
    }
    
    func createRecommendTeaHouseSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 20.0, bottom: 0, trailing: 20.0)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3106))
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3106))
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

// MARK: - MoreButton Delegate
extension HomeViewController: MoreButtonDelegate {
    func moreButtonDidTap(_ section: Int) {
        print(section, "didTap")
    }
}
