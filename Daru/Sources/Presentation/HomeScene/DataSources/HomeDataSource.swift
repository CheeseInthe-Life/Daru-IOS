//
//  HomeDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/05/30.
//

import UIKit
import RxDataSources

typealias HomeSectionModel = SectionModel<String,String>

struct HomeDataSource {
    static func dataSource(delegate: MoreButtonDelegate) -> RxCollectionViewSectionedReloadDataSource<HomeSectionModel> {
        return .init {
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
