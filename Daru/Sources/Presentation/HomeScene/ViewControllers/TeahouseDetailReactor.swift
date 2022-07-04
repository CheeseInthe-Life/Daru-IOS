//
//  TeahouseDetailReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/07/05.
//

import Foundation
import ReactorKit
import RxCocoa
import RxFlow

final class TeahouseDetailReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var steps: PublishRelay<Step> = .init()
    var initialState: State = .init()
}
