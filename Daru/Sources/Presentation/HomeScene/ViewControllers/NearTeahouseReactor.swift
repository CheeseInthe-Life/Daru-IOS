//
//  NearTeahouseReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/05/29.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class NearTeahouseReactor: Reactor, Stepper {
    
    enum Action {
        case refresh(locationPermissionType: LocationPermissionType)
    }
    
    enum Mutation {
        case setSections(sections: [NearTeahouseSectionModel])
        case setLocationPermissionType(type: LocationPermissionType)
    }
    
    struct State {
        @Pulse var sections: [NearTeahouseSectionModel] = []
        var locationPermissionType: LocationPermissionType = .notDetermined
    }
    
    let initialState: State = .init()
    let steps: PublishRelay<Step> = .init()
    
    let notAllowLocationPermissionSections = [
        NearTeahouseSectionModel(model: "", items: [.titleSectionItem(type: .notDetermined)]),
        NearTeahouseSectionModel(model: "", items: [.locationPermissionButtonSectionItem])
    ]
    
    let dummySections = [
        NearTeahouseSectionModel(model: "", items: [.titleSectionItem(type: .allow)]),
        NearTeahouseSectionModel(
            model: "",
            items: [
                .teaHouseSectionItem,
                .teaHouseSectionItem,
                .teaHouseSectionItem,
                .teaHouseSectionItem,
                .teaHouseSectionItem,
                .teaHouseSectionItem,
                .teaHouseSectionItem
            ])
    ]
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .refresh(locationPermissionType):
            switch locationPermissionType {
            case .notDetermined, .denied:
                return .concat([
                    .just(Mutation.setLocationPermissionType(type: locationPermissionType)),
                    .just(Mutation.setSections(sections: notAllowLocationPermissionSections))
                    ])
            case .allow:
                return .concat([
                    .just(Mutation.setLocationPermissionType(type: locationPermissionType)),
                    .just(Mutation.setSections(sections: dummySections))
                ])
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSections(let sections):
            newState.sections = sections
        case .setLocationPermissionType(let type):
            newState.locationPermissionType = type
        }
        
        return newState
    }
}

