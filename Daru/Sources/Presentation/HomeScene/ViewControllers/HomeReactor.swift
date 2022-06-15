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
        case kakaoLogin(accessToken: String)
    }
    
    enum Mutation {
        case setLoginState(isLogined: Bool)
    }
    
    struct State {
        var sections: [HomeSectionModel]
        var isLogined: Bool
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
        ],
        isLogined: false
    )
    
    private let keyChainService: KeyChainServiceType
    private let authService: AuthServiceType
    
    init(
        keyChainService: KeyChainServiceType,
        authService: AuthServiceType
    ) {
        self.keyChainService = keyChainService
        self.authService = authService
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
        case .kakaoLogin(let accessToken):
            return authService.signIn(providerType: .kakao, accessToken: accessToken)
                .compactMap {
                    guard case .success() = $0 else { return nil }
                    return Mutation.setLoginState(isLogined: true)
                }.asObservable()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var newState = state
        
        switch mutation {
        case .setLoginState(let isLogined):
            newState.isLogined = isLogined
        }
        
        return newState
    }
}


