//
//  InputInfoReactor.swift
//  Daru
//
//  Created by 재영신 on 2022/06/17.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import RxSwift

final class InputInfoReactor: Reactor, Stepper {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State = .init()
    var steps: PublishRelay<Step> = .init()
}
