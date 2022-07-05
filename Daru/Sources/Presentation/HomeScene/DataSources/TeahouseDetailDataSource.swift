//
//  TeahouseDetailDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import UIKit
import RxDataSources

typealias TeahouseDetailSectionModel = SectionModel<String, TeahouseDetailSectionItem>

enum TeahouseDetailSectionItem {
    case titleSection
    case addressSection
}

struct TeahouseDetailDataSource {
    static func dataSource() -> RxCollectionViewSectionedReloadDataSource<TeahouseDetailSectionModel> {
        return .init {
            dataSource, collectionView, indexPath, item in
            switch item {
            case .titleSection:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeahouseDetailTitleCell.identifier,
                    for: indexPath
                ) as! TeahouseDetailTitleCell
                return cell
            case .addressSection:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeahouseDetailAddressCell.identifier,
                    for: indexPath
                ) as! TeahouseDetailAddressCell
                return cell
            }
        }configureSupplementaryView: {
            dataSource, collectionView, type, indexPath in
            switch indexPath.section {
            case 1:
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: type,
                    withReuseIdentifier: TeahouseDetailHeaderView.identifier,
                    for: indexPath) as! TeahouseDetailHeaderView
                view.update(with: dataSource.sectionModels[indexPath.section].model)
                return view
            default:
                return UICollectionReusableView()
            }
        }
    }
}
