//
//  TabReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import Foundation
import RxFlow
import ReactorKit
import RxCocoa

final class TabReactor: Reactor, Stepper {
    
    enum Action {
        case settingIsRequired
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State = .init()
    var steps: PublishRelay<Step> = .init()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .settingIsRequired:
            steps.accept(DaruStep.settingIsRequired)
            return .empty()
        }
    }
}
