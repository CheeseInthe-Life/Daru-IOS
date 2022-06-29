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
        case changeLocation(location: String)
        case settingAlertIsRequired
    }
    
    enum Mutation {
        case setSections(sections: [NearTeahouseSectionModel])
        case setLocationPermissionType(type: LocationPermissionType)
        case setLocation(String)
    }
    
    struct State {
        @Pulse var sections: [NearTeahouseSectionModel] = []
        var locationPermissionType: LocationPermissionType = .notDetermined
        var location: String?
    }
    
    let initialState: State = .init()
    let steps: PublishRelay<Step> = .init()
    
    let notAllowLocationPermissionSections = [
        NearTeahouseSectionModel(model: "", items: [.locationPermissionButtonSectionItem])
    ]
    
    let dummySections = [
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
                    .just(Mutation.setSections(sections: [
                        NearTeahouseSectionModel(model: "", items: [.titleSectionItem(type: currentState.locationPermissionType, location: currentState.location)])
                    ] + notAllowLocationPermissionSections))
                    ])
            case .allow:
                return .concat([
                    .just(Mutation.setLocationPermissionType(type: locationPermissionType)),
                    .just(Mutation.setSections(sections: [
                        NearTeahouseSectionModel(model: "", items: [.titleSectionItem(type: currentState.locationPermissionType, location: currentState.location)])
                    ] + dummySections))
                ])
            }
        case .settingAlertIsRequired:
            steps.accept(DaruStep.settingAlertIsRequired)
            return .empty()
        case .changeLocation(let location):
            var newSection = currentState.sections
            newSection[0] = NearTeahouseSectionModel(model: "", items: [
                .titleSectionItem(type: currentState.locationPermissionType, location: location)
            ])
            return .concat([
                .just(Mutation.setLocation(location)),
                .just(Mutation.setSections(sections: newSection))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSections(let sections):
            newState.sections = sections
        case .setLocationPermissionType(let type):
            newState.locationPermissionType = type
        case .setLocation(let location):
            newState.location = location
        }
        
        return newState
    }
}

