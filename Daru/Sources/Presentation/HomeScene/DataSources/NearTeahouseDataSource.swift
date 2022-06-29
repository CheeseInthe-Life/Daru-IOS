//
//  NearTeahouseDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import UIKit
import RxDataSources

typealias NearTeahouseSectionModel = SectionModel<String,NearTeahouseSectionItem>

enum NearTeahouseSectionItem {
    case titleSectionItem(type: LocationPermissionType)
    case teaHouseSectionItem
    case locationPermissionButtonSectionItem
}

struct NearTeahouseDataSource {
    static func dataSource(delegate: LocationPermissionButtonDelegate) -> RxCollectionViewSectionedReloadDataSource<NearTeahouseSectionModel> {
        return .init {
            dataSource, collectionView, indexPath, item in
            switch item {
            case .titleSectionItem(let type):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NearTeahouseTitleCell.identifier,
                    for: indexPath
                ) as! NearTeahouseTitleCell
                cell.update(with: type)
                return cell
            case .teaHouseSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeaHouseCell.identifier,
                    for: indexPath
                ) as! TeaHouseCell
                return cell
            case .locationPermissionButtonSectionItem:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LocationPermissionButtonCell.identifier,
                    for: indexPath
                ) as! LocationPermissionButtonCell
                cell.delegate = delegate
                return cell
            }
        }configureSupplementaryView: {
            dataSource, collectionView, type, indexPath in
            switch indexPath.section {
            case 1:
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: TeahouseListHeaderView.identifier,
                    for: indexPath
                ) as! TeahouseListHeaderView
                view.update(with: "내 주변 찻집")
                return view
            default:
                return UICollectionReusableView()
            }
        }
    }
}
