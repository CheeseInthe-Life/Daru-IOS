//
//  NearTeahouseDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/05/31.
//

import UIKit
import RxDataSources

typealias NearTeahouseSectionModel = SectionModel<String,String>

struct NearTeahouseDataSource {
    static func dataSource() -> RxCollectionViewSectionedReloadDataSource<NearTeahouseSectionModel> {
        return .init {
            dataSource, collectionView, indexPath, item in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: NearTeahouseTitleCell.identifier,
                    for: indexPath
                ) as! NearTeahouseTitleCell
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeaHouseCell.identifier,
                    for: indexPath
                ) as! TeaHouseCell
                return cell
            default:
                return UICollectionViewCell()
            }
        }configureSupplementaryView: {
            dataSource, collectionView, type, indexPath in
            switch indexPath.section {
            case 1:
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: NearTeahouseSceneHeaderView.identifier,
                    for: indexPath
                ) as! NearTeahouseSceneHeaderView
                return view
            default:
                return UICollectionReusableView()
            }
        }
    }
}
