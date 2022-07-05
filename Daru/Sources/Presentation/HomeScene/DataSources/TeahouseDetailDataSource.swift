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
            }
        }
    }
}
