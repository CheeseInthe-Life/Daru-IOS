//
//  HomeDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/05/30.
//

import UIKit
import RxDataSources

typealias HomeSectionModel = SectionModel<String,HomeSectionItem>

enum HomeSectionItem {
    case bannerSectionItem
    case recommendTeahouseSectionItem
    case loginButtonSectionItem
    case nearTeahouseSectionItem
    case recentPostSectionItem
    case regionCategorySectionItem
    case footerSectionItem
}

struct HomeDataSource {
    static func dataSource(delegate: MoreButtonDelegate) -> RxCollectionViewSectionedReloadDataSource<HomeSectionModel> {
        return .init {
            datasource, collectionView, indexPath, item in
            switch item {
            case .bannerSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BannerCell.identifier,
                    for: indexPath
                ) as! BannerCell
                cell.update(with: [Constant.banner!, Constant.banner!, Constant.banner!])
                return cell
            case .nearTeahouseSectionItem, .recommendTeahouseSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeaHouseCell.identifier,
                    for: indexPath
                ) as! TeaHouseCell
                return cell
            case .recentPostSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PostCollectionViewCell.identifier,
                    for: indexPath
                ) as! PostCollectionViewCell
                return cell
            case .regionCategorySectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RegionCategoryCell.identifier,
                    for: indexPath
                ) as! RegionCategoryCell
                return cell
            case .footerSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeFooterCell.identifier,
                    for: indexPath
                ) as! HomeFooterCell
                return cell
            case .loginButtonSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LoginButtonCell.identifier,
                    for: indexPath
                ) as! LoginButtonCell
                return cell
            }
        }configureSupplementaryView: { dataSource, collectionView, type, indexPath in
            if indexPath.section == 1 {
                if type == UICollectionView.elementKindSectionHeader {
                    let view = collectionView.dequeueReusableSupplementaryView(
                        ofKind: type,
                        withReuseIdentifier: HomeRecommendTeaHouseSectionHeaderView.identifier,
                        for: indexPath
                    ) as! HomeRecommendTeaHouseSectionHeaderView
                    view.delegate = delegate
                    return view
                } else {
                    let view = collectionView.dequeueReusableSupplementaryView(
                        ofKind: type,
                        withReuseIdentifier: HomeRecommendTeaHouseSectionFooterView.identifier,
                        for: indexPath
                    ) as! HomeRecommendTeaHouseSectionFooterView
                    return view
                }
            } else if indexPath.section == 2 {
                if type == UICollectionView.elementKindSectionHeader {
                    let view = collectionView.dequeueReusableSupplementaryView(
                        ofKind: type,
                        withReuseIdentifier: HomeNearTeaHouseSectionHeaderView.identifier,
                        for: indexPath
                    ) as! HomeNearTeaHouseSectionHeaderView
                    view.delegate = delegate
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
    }
}
