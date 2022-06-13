//
//  HomeReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/17.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import RxSwift

final class HomeReactor: Reactor, Stepper {
    
    enum Action {
        case moreButtonDidTap(section: Int)
        case refresh
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var sections: [HomeSectionModel]
    }
    
    var steps: PublishRelay<Step> = .init()
    
    let initialState: State = State(
        sections: [
            HomeSectionModel(model: "", items: [HomeSectionItem.bannerSectionItem]),
            HomeSectionModel(model: "", items: [.loginButtonSectionItem]),
            HomeSectionModel(model: "", items: [.nearTeahouseSectionItem,.nearTeahouseSectionItem,.nearTeahouseSectionItem]),
            HomeSectionModel(model: "", items: [.recentPostSectionItem,.recentPostSectionItem]),
            HomeSectionModel(model: "", items: [
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem,
                .regionCategorySectionItem
            ]),
            HomeSectionModel(model: "", items: [.footerSectionItem])
        ]
    )
    
    private let keyChainService: KeyChainServiceType
    
    init(keyChainService: KeyChainServiceType) {
        self.keyChainService = keyChainService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .moreButtonDidTap(section):
            switch section {
            case 1:
                steps.accept(DaruStep.recommendTeahouseIsRequired)
            case 2:
                steps.accept(DaruStep.nearTeahouseIsRequired)
            default:
                break
            }
            return .empty()
        case .refresh:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        
//        switch mutation {
//        case .setIsLogined(let isLogined):
//
//        }
        
        return newState
    }
}


