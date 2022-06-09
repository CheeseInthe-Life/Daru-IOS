//
//  PostDetailDataSource.swift
//  Daru
//
//  Created by 재영신 on 2022/06/09.
//

import UIKit
import RxDataSources

typealias PostDetailSectionModel = SectionModel<String,String>

struct PostDetailDataSource {
    static func dataSource() -> RxCollectionViewSectionedReloadDataSource<PostDetailSectionModel> {
        return .init {
            dataSource, collectionview, indexPath, item in
            switch indexPath.section {
            case 0:
                let cell = collectionview.dequeueReusableCell(
                    withReuseIdentifier: PostContentCell.identifier,
                    for: indexPath
                ) as! PostContentCell
                return cell
            case 1:
                let cell = collectionview.dequeueReusableCell(
                    withReuseIdentifier: PostCommentCell.identifier,
                    for: indexPath
                ) as! PostCommentCell
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
}
