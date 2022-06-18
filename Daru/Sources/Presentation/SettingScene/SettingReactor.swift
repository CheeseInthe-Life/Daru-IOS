//
//  SettingReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/06/18.
//

import Foundation
import ReactorKit
import RxCocoa
import RxFlow

final class SettingReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State = .init()
    var steps: PublishRelay<Step> = .init()
    
}
